Message-ID: <396F59AC.AD522F00@execpc.com>
Date: Fri, 14 Jul 2000 13:19:24 -0500
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: Derek Homeier <supas100@astrophysik.uni-kiel.de>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: switching consoles
References: <Pine.SOL.3.95.1000714193210.28063B-100000@juliet>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Derek Homeier wrote:
> Generally, however, I prefer to set the primary function of the F[1-12]
> keys to "Function keys" in the "Options" of the "Keyboard" Control Panel.
> BTW, this seems to be reset whenever my OF variables are set back to defaults.
> Does anyone know if it is possible to change this setting in OF directly?

I suppose you could try setting it back and forth and getting a hexdump of nvram
and then diff them to find the common thread.  then write an app that does it
for you.

Kinda brute force, but thats how I wrote setpramboot and got it working for my
PDQ. (http://www.execpc.com/~jpgarcia)  The F[1-12] keys thing could be as
little as a single bit, right?

--
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

Its not about MHz, its about who's got the bigger endian.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
