Message-ID: <A109131318C4D1119AC20060088DECE330F48A@amwmail.adaptivemicro.com>
From: Lucinda Schafer <lucsch@adaptivemicro.com>
To: Kwansuk Kim <kskim@neowave.co.kr>, linuxppc-embedded@lists.linuxppc.org
Subject: RE: Where can I get gcc,binutil, etc for PPC on cygwin
Date: Wed, 21 Jun 2000 08:30:42 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I recommend installing Redhat or similar on your computer--dual boot if you
have to. We found this was a lifesaver in retrospect for our project! It is
so much easier to work on your project--one thing we do is mount our PC
Linux drive to our embedded board and run our program from there. We use
smb to interface our Windows networked PCs to our Linux "server" so we can
use our favorite Windows-based editor. We telnet to the Linux server to run
compiles.

Then run your BDM from a Windows computer, using the dual boot,if you only
have one computer.

Lucinda Schafer
Staff Software Engineer
Adaptive Micro-Ware, Inc.

-----Original Message-----
From: Kwansuk Kim [mailto:kskim@neowave.co.kr]
Sent: Wednesday, June 21, 2000 2:12 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Where can I get gcc,binutil, etc for PPC on cygwin



Hmm...

I've already got GCC from GNU and cross developement kit from redhat, and
so on.

But they are all for linux host, not windows host.

I tried to compile the sources on cygwin and djgpp, I fail. Because there
are too many errors which did occured during compilation on Linux.

I need compiler bin file for cygwin or djgpp host,
or
patch or how to compile cross compiler for powerpc operating on Windows.

I even tried canadian crossing on linux, there were also many errors.


-----Original Message-----
From: sungyeon [mailto:sungyeon@cosmo.etri.re.kr]
Sent: Wednesday, June 21, 2000 1:03 PM
To: Kwansuk Kim; linuxppc-embedded@lists.linuxppc.org
Subject: Re: Where can I get gcc,binutil, etc for PPC on cygwin


You can find out at..

GCC: http://gcc.gnu.org
binutils: http://www.gnu.org/gnulist/production/binutils.html


----- Original Message -----
From: "Kwansuk Kim" <kskim@neowave.co.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Wednesday, June 21, 2000 12:17 PM
Subject: Where can I get gcc,binutil, etc for PPC on cygwin


>
> Unfortunatly my BDM kit doesn't support Linux but Windows
>
> So I searched for cross compiler on cygwin or djgpp but I couldn't find
it.
>
> Is there anyone using that compiler? Or how can I get them?
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
