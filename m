Message-ID: <003701c09760$1b754a20$74dee783@lboro.ac.uk>
From: "Peter Uttley" <P.Uttley-97@student.lboro.ac.uk>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Embedded Linux for data acquisition and  control
Date: Thu, 15 Feb 2001 15:00:26 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Everyone,

Hope someone can give me a bit of advice on the best way to tackle a
university project I'm working on.

OK, I've currently ported Linux to my embedded MPC-850 board, many thanks to
the help of Frank Przybylski with his BDM4GDB and the invaluable advice from
Wolfgang Denx, thanks Guys!

Now what I want to do with the board is use it for data acquisition and
control of peripheral systems via a web interface.
I'm currently building my peripheral hardware which then simply dumps the
data down the serial port to the MPC-850.

I would really appreciate some advice on the best why to handle the data
coming in on the serial port and get it into the webserver.

My initial thoughts are,

I write a bit of software which monitors the serial port and has its own
little protocols with my peripheral hardware, the data is then written into
a file which is read by my web server (I'm using GoAhead-Thanks for the
pointer Frank) which has a active server page to display the information.

However this seems a bit of a hack way of doing it, and could cause problems
when I'm trying to send data to my device to electronically open an door for
instance.

Is it possible therefore to directly receive and transmit data from my web
server to the serial port, I know you can write any C code in ASP or CGI
scripts but I need to have some sort of control, monitoring, waiting for
data e.t.c. which seem best handled by some sort of daemon or device driver.

Hope that makes sense and that someone can give me a few clues as to which
direction I should take, the project time schedules quite tight so I don't
want to be heading down too much of a blind alley.

Thanks for you time,

Regards,

Pete.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
