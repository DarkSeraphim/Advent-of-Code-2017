import scala.math._

object Main {
    val OFFSETS = List((-1, 1), (0,1), (1,1),
                       (-1, 0), (0,0), (1,0),
                       (-1,-1), (0,-1),(1,-1))

    def main(args: Array[String]) {
	    val number = 368078;
	    println(s"Your number is: ${findDistance(number)}");
    }

    def findDistance(number: Int): Int = {
        if (number == 1)
            2
        else {
            val radius = findRadius(number);
            println(radius)
            val first = findFirst(radius);
            val cx = ceil(radius / 2.0).toInt;
            val cy = cx;
            
            var table = Array.fill[Int](radius, radius)(0);
            table(cy - 1)(cx - 1) = 1
            
            
            var r = 1
            var x = cx + 1
            var y = cy
            var it = 0
            var cur = updateSum(x, y, table)
            while (cur <= number) {
                if (it == 0) {
                    y += 1
                    if (y - cy == r)
                        it = 1
                } else if (it == 1) {
                    x -= 1
                    if (x - cx == -r)
                        it = 2
                } else if (it == 2) {
                    y -= 1
                    if (y - cy == -r)
                        it = 3
                } else {
                    x += 1
                    if (x - cx == r + 1) {
                        it = 0
                        r += 1
                    }
                }
                cur = updateSum(x, y, table)
            }
            
            cur
        }
    }

    def updateSum(x: Int, y: Int, table: Array[Array[Int]]): Int = {
        var px = x - 1
        var py = y - 1
        table(py)(px) = OFFSETS.map(offset => {
            val (dx, dy) = offset
            (px + dx, py + dy)
        }).map(xy => {
            val (xx, yy) = xy
            findValue(xx, yy, table)
        }).foldLeft(0)(_ + _)
        table(py)(px)
    }
    
    def findValue(x: Int, y: Int, table: Array[Array[Int]]): Int = {
        if (y < 0 || y >= table.length)
            0
        else {
            val row = table(y);
            if (x < 0 || x >= row.length)
                0
            else
                row(x);
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
