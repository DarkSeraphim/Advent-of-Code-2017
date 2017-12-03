import scala.math._

object Main extends App {
	override def main(args: Array[String]) {
	    val number = scala.io.StdIn.readInt();
	    println(s"Your distance is: ${findDistance(number)}");
    }

    def findDistance(number: Int): Int = {
        if (number == 1)
            number
        else {
            val radius = findRadius(number);
            val first = findFirst(radius);
            val cx = ceil(radius / 2.0).toInt;
            val cy = cx;
            var x = cx + radius / 2;
            var y = cx - (radius / 2) + 1;
            var left = number - first;
            var it = 0;
            while (left > 0) {
                var con = radius - 1
                if (it == 0) {
                    y += min(left, radius - 2);
                    con = radius - 2;
                } else if (it == 1) {
                    x -= min(left, radius - 1);
                } else if (it == 2) {
                    y -= min(left, radius - 1);
                } else {
                    x += min(left, radius - 1);
                }
                it += 1;
                left -= con;
            }
            abs(x - cx) + abs(y - cy)
        }
    }

    def findRadius(number: Int): Int = {
        val s = ceil(sqrt(number)).toInt
        if (s % 2 == 0)
            s + 1
        else
            s
    }

    def findFirst(radius: Int): Int = {
        if (radius == 1)
            radius
        else
            (pow(radius - 2, 2) + 1).toInt
    }
}
