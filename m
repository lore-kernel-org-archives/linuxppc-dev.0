Message-ID: <E1836A7F3557D311A14000805F9F36FC0141C856@usdfo011.usac.danfoss.net>
From: Hihn Jason <JasonHihn@DANFOSS.com>
To: "'John.Fisher@nec.com.au'" <John.Fisher@nec.com.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: cygwin and embedded linux
Date: Thu, 22 Aug 2002 15:06:06 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Why not just set up ONE Linux computer and have people login to it?
Use SAMBA to map drives off the Linux box if you want to use your
proprietary IDEs
-or- use Cygwin Xfree86 (or a proprietary product, i.e. eXceed) to run an X
server and run KDevelop (or whatever off the Linux box with display to your
local windows PC)

With Linux and Unix-based tools and technologies, the possible developmental
infrastructure configurations are endless!

-Jason Hihn
I reserve the right to be wrong.



-----Original Message-----
From: John Fisher [mailto:John.Fisher@nec.com.au]
Sent: Wednesday, August 21, 2002 9:15 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: cygwin and embedded linux



> Actually, my personal opinion on that matter is that I'm not very fond
> of using Windows for a Linux kernel development platform. Doing --

So what are the issues: How is cygwin significantly different from Linux
that you would not want to use it?
Are there useful tools that run under Linux but not under cygwin?

The reason I ask is that my organization currently does its software
development under windows using proprietary tools. We have to maintain our
existing products using these tools. We are however contemplating new
development using linux. If we have to dual boot our PCs or have an extra PC
running Linux for each developer, that is going to bring its own set of
nuisances and problems.

Are there others in this situation and how have they chosen to solve it?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
