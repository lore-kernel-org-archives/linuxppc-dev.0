Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: Brian Waite <waite@skycomputers.com>
To: Tom Rini <trini@kernel.crashing.org>,
	Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: BOOT_TARGET pImage & uImage ???
Date: Thu, 18 Sep 2003 14:22:28 -0400
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
References: <3F65917D.1020502@imc-berlin.de> <3F699255.4050000@imc-berlin.de> <20030918180834.GC6692@ip68-0-152-218.tc.ph.cox.net>
In-Reply-To: <20030918180834.GC6692@ip68-0-152-218.tc.ph.cox.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200309181422.32546.waite@skycomputers.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



> What I want is three things:
> 1) The 'mkimage' target must be done in such a fashion that it will
> never run into a 'cannot execute' problem.  My suggestion is to have the
> Makefile do a:
> @chmod +x mkimage.sh
> Or so.  In 2.5/2.6, the build system will handle this for you,
> automagically, on .sh files I believe.  For 2.4, you must handle this
> explicitly.
Altough messy, I make this happen in the patch I supply. I can change it to do
the straight chmod in the scrip[ts directory if that is cleaner.

> 2) Do we really need 'pImage' and 'uImage' or can we just have 'uImage'
> ?
I think uImage is enough. Wolfgang strongly discourages any use of PPCBoot
these days and it just seems silly.
> 3) I really (really!) want a patch for 2.4 and 2.5/2.6 at the same time.
This was one of the reasons for not supplying the patch previously.
I will try to pull together a 2.5/2.6 patch but I have not worked under
2.5/2.6 at all. When I initially did the 2.4 patch I pulled the 2.5 tree but
I didn't have time to understand the layout. Also, unless someone has a board
that will boot a uImage target I can only supply an untested patch. I'll take
some time and see if I can pull something I am comfortable with in the next
few days. Is there anyone who could help with testing?

Thanks
Brian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
