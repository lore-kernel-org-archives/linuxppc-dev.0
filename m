Message-Id: <4.3.2.20000621074546.00b6f7f0@falcon.si.com>
Date: Wed, 21 Jun 2000 07:50:52 -0400
To: "Kwansuk Kim" <kskim@neowave.co.kr>,
        <linuxppc-embedded@lists.linuxppc.org>
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: RE: Where can I get gcc,binutil, etc for PPC on cygwin
In-Reply-To: <NEBBKFENMLEDKDHMEHPJAELICAAA.kskim@neowave.co.kr>
References: <009101bfdb35$99d5ab90$5a01a8c0@blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


WindRiver TornadoII toolset is based on cygwin/gcc.  This would imply
that you should be able to get the sources from somewhere.  I have not
tried, personally.  If you track down the version numbers below at
Cygnus, you may find something that works.  Otherwise, sending money to
WindRiver and/or Cygnus should work (LOTS of money in the case of
WindRiver :-).

C:\>ccppc -v
gcc driver version cygnus-2.7.2-960126 egcs-971225 tornado 2.0
executing gcc version cygnus-2.7.2-960126

C:\>bash --version
GNU bash, version 2.01.1(2)-release (i386-pc-cygwin32)
Copyright 1997 Free Software Foundation, Inc.

gvb


At 04:11 PM 6/21/00 +0900, Kwansuk Kim wrote:

>Hmm...
>
>I've already got GCC from GNU and cross developement kit from redhat,
>and so on.
>
>But they are all for linux host, not windows host.
>
>I tried to compile the sources on cygwin and djgpp, I fail. Because
>there are too many errors which did occured during compilation on Linux.
>
>I need compiler bin file for cygwin or djgpp host,
>or
>patch or how to compile cross compiler for powerpc operating on Windows.
>
>I even tried canadian crossing on linux, there were also many errors.
>
>
>-----Original Message-----
>From: sungyeon [mailto:sungyeon@cosmo.etri.re.kr]
>Sent: Wednesday, June 21, 2000 1:03 PM
>To: Kwansuk Kim; linuxppc-embedded@lists.linuxppc.org
>Subject: Re: Where can I get gcc,binutil, etc for PPC on cygwin
>
>
>You can find out at..
>
>GCC: http://gcc.gnu.org
>binutils: http://www.gnu.org/gnulist/production/binutils.html
>
>
>----- Original Message -----
>From: "Kwansuk Kim" <kskim@neowave.co.kr>
>To: <linuxppc-embedded@lists.linuxppc.org>
>Sent: Wednesday, June 21, 2000 12:17 PM
>Subject: Where can I get gcc,binutil, etc for PPC on cygwin
>
>
> >
> > Unfortunatly my BDM kit doesn't support Linux but Windows
> >
> > So I searched for cross compiler on cygwin or djgpp but I couldn't
> find it.
> >
> > Is there anyone using that compiler? Or how can I get them?
> >
> >
> >
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
