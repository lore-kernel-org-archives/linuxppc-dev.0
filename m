To: Alejandro Erives <pelochino@hotvoice.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: TCP/IP Performance 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 04 Dec 2001 17:12:34 EST."
             <6776269.1007503954578.JavaMail.tester@hvwww8>
Date: Tue, 04 Dec 2001 23:27:46 +0100
Message-Id: <20011204222751.A88EBF9C0@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <6776269.1007503954578.JavaMail.tester@hvwww8> you wrote:
>
> Where can I find information relating to the performance (frames/second,
> etc) of TCP/IP under PowerPC embedded Linux?  Would this be
> different depending upon the device?  The devices in consideration
> are the MPC860 and the MPC8260.  Thank you for all your help.

Of course this depends a lot on the device - ethernet on a  SCC  port
on  a MPC8xx is different from ethernet on a FEC on a MPC860-T or -P,
which in trun is different from ethernet on a FCC on a 8260. Add  the
different  speed  of  the  CPU's, differend speed of their bus inter-
faces, etc.

It makes a LOT of difference. But then, there is also a price
difference...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If programming was easy, they wouldn't need something as  complicated
as a human being to do it, now would they?
                       - L. Wall & R. L. Schwartz, _Programming Perl_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
