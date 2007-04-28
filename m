Return-Path: <melinda.develey70@yahoo.com>
Received: from web63903.mail.re1.yahoo.com (web63903.mail.re1.yahoo.com
	[69.147.97.118]) by ozlabs.org (Postfix) with SMTP id 50F9BDDF41
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 29 Apr 2007 07:46:05 +1000 (EST)
Date: Sat, 28 Apr 2007 14:46:04 -0700 (PDT)
From: melinda develey <melinda.develey70@yahoo.com>
Subject: Using /dev/rtc causes message "system delaying clock ticks?"
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-944088738-1177796764=:5915"
Message-ID: <652572.5915.qm@web63903.mail.re1.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-944088738-1177796764=:5915
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I'm using an MPC885 with the linux kernel rtc emulator driver. Because I need to wake a process every second, exactly synchronized with the rtc, I'm using the following code snippet:

____________________________________________
/* Turn on update interrupts (one per second) */
retval = ioctl(fd, RTC_UIE_ON, 0);
if (retval == -1) {
        perror("ioctl");
        exit(errno);
}

while (1)
{
        /* This read will block */
        retval = read(fd, &data, sizeof(unsigned long));
        if (retval == -1) {
                perror("read");
                exit(errno);
        }
       /* Do something exactly synchronized with RTC */
       /* ...... */
}

_________________________________________


>From time to time I receive the message on the subject. What's happening?


Bye,
Melinda.


       
---------------------------------
Ahhh...imagining that irresistible "new car" smell?
 Check outnew cars at Yahoo! Autos.
--0-944088738-1177796764=:5915
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I'm using an MPC885 with the linux kernel rtc emulator driver. Because I need to wake a process every second, exactly synchronized with the rtc, I'm using the following code snippet:<br><br>____________________________________________<br>/* Turn on update interrupts (one per second) */<br>retval = ioctl(fd, RTC_UIE_ON, 0);<br>if (retval == -1) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; perror("ioctl");<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exit(errno);<br>}<br><br>while (1)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* This read will block */<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval = read(fd, &amp;data, sizeof(unsigned long));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval == -1) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; perror("read");<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 exit(errno);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Do something exactly synchronized with RTC */<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ...... */<br>}<br><br>_________________________________________<br><br><br>From time to time I receive the message on the subject. What's happening?<br><br><br>Bye,<br>Melinda.<br><br><p>&#32;

      <hr size=1>Ahhh...imagining that irresistible "new car" smell?<br> Check out
<a href="http://us.rd.yahoo.com/evt=48245/*http://autos.yahoo.com/new_cars.html;_ylc=X3oDMTE1YW1jcXJ2BF9TAzk3MTA3MDc2BHNlYwNtYWlsdGFncwRzbGsDbmV3LWNhcnM-">new cars at Yahoo! Autos.</a>

--0-944088738-1177796764=:5915--
