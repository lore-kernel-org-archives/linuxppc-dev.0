Message-ID: <398A9323.7B72B918@student.ethz.ch>
Date: Fri, 04 Aug 2000 11:55:47 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Andreas Tobler <toa@pop.agri.ch>
CC: Linuxppc-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: XF4 Sources HELP
References: <398A8610.C4944925@pop.agri.ch>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Andreas Tobler wrote:

> I'd like to enter the XF4 world, but I can't download the whole 40 or more
> MegaBytes. I have the 4.0.0 sources and the 4.0.1 diffs. Now question nbr1:
> how do I create the three tar.gz out of an expanded XF4 source tree?

Why would you want to create them at all?


> Next question, is it possible to update an expanded tree via cvs? I tried
> before but I got rejected:
>  'cvs server: cannot find module `xc' - ignored' , this was outside the  xc
> dir.

The error suggests that something was wrong with the CVS root you specified.

> Does this really work or am I lost?

You can only update via CVS if there is a CVS/ directory in every source
directory which contains files describing the root of the repository etc.

Otherwise you have to checkout the whole tree from CVS first.


Michel


--
What do you mean, my birth certificate expired?
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
