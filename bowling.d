import std.stdio;
import std.conv;

void main(string[] args) {
   version (unittest) {
      if (args.length < 2) {
         return;
      }
   }
   string line = args[1];

   writeln(score(line));
}

int score(string line) {
   int full_score;
   int throw_index; // throws/frame varies.

   for (int framecount; framecount < 10; framecount++) {
      version (unittest) {
         writeln("Frame: " ~ to!string(framecount + 1));
         writeln("Throw index: " ~ to!string(throw_index));
         writeln("Current throw: " ~ line[throw_index .. throw_index+1]);
      }
      if (line[throw_index+1] == '/') { //skip this throw and just add spare score + bonus.
         full_score += 10 + single_throw_score(line[throw_index+2 .. throw_index+3]);
         throw_index += 2; //advance past the whole frame
         //end spare handling
      } else { //no need to skip
         full_score += single_throw_score(line[throw_index .. throw_index+1]);
         if (line[throw_index] != 'X') {
            //need to grab next throw before advancing the framecount
            throw_index++;
            full_score += single_throw_score(line[throw_index .. throw_index+1]);
         } else {
            //need to determine strike bonus
            if (line[throw_index+2] == '/') {
               full_score += 10;
            } else {
               full_score += single_throw_score(line[throw_index+1 .. throw_index+2]) +
                  single_throw_score(line[throw_index+2 .. throw_index+3]);
            }
         }
         throw_index++; //advance throw index in sync with framecount
         //end regular throw handling
      }
      version (unittest) {
         writeln("Current Score: " ~ to!string(full_score));
      }
   }

   return full_score;
} unittest {
   int passed;
   writeln("all strikes");
   if (score("XXXXXXXXXXXX") == 300) {
      writeln("all strikes passed");
      passed++;
   }
   writeln("----");
   writeln("no strikes + misses");
   if (score("9-9-9-9-9-9-9-9-9-9-") == 90) {
      writeln("no strikes + misses passed");
      passed++;
   }
   writeln("----");
   writeln("all spares");
   if (score("5/5/5/5/5/5/5/5/5/5/5") == 150) {
      writeln("spares passed");
      passed++;
   }
   writeln("----");
   writeln("mix");
   if (score("X7/9-X-88/-6XXX81") == 167) {
      writeln("mix passed");
      passed++;
   }
   writeln("passed " ~ to!(string)(passed) ~ "/4 test cases.");
   assert(passed == 4);
}

int single_throw_score(string single)
in {
   assert(single.length == 1);
} do {
   switch (single) {
      case "X":
         return 10;
      case "-":
         return 0;
      default:
         return to!(int)(single);
   }
}
