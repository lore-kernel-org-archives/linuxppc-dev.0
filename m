Message-ID: <3D13AA39.5884FBD4@esteem.com>
Date: Fri, 21 Jun 2002 15:35:37 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: "Cameron, Steve" <Steve.Cameron@hp.com>,
	May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Can I run linux without a file system?
References: <45B36A38D959B44CB032DA427A6E10640167CFE3@cceexc18.americas.cpqcorp.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Cameron, Steve" wrote:
>
> Dr. Craig Hollabaugh wrote:
> >
> > I can say that a minimum RedHat install uses 29,296 files -
> > 382.020MB, debian 10,734 files - 67.428MB, my minimal root
> > filesystem 82 files and 4.8MB.
> >
>
> Hmm, my minimal rootfs is (so far) 7 Mb, (as reported by du -s).
> Or, is this 4Mb you cite compressed?  I wonder because my
> libc.so is over 5 Mb. (which I got from DENX eldk-1.0)
>

Did you use ppc-8xx-strip on it? It gets rid of all that nasty
debugging bloat. Our libc is 1275512 bytes after stripping. Our
uncompressed ramdisk is 4879K. If you are realy hurting try rebuilding
everything using the "-Os -mstring -mmultiple" optimizations.


As for the original question "Can I run linux without a file system?",
If you don't need a file system, mabey the question should be do you
realy need linux. It may just be easier to make an executable to sit
on something like PPCBoot. (just a thought)

good luck.

	Conn
--

*****************************************************************
  If you live at home long enough, your parents will move out.
 (Warning they may try to sell their house out from under you.)
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
