Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <01C19DC3.ED0B5150.svacca@valcom.com>
From: Steven Vacca <svacca@valcom.com>
Reply-To: "svacca@valcom.com" <svacca@valcom.com>
To: "LinuxEmbeddedMailList (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: mpc860 vs. mpc860T 
Date: Tue, 15 Jan 2002 12:55:35 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Yes!  Yes!  Success!

I transferred the CONFIG_8xx_CPU6 patches from the
linuxPPC sources into my kernel and that solved my
problems with the old version of the 860T.

"Thanks a quadrillion for your help!"
     /
  \O/
   \/      <---- Steven
 _/\_



-----Original Message-----
From:	Wolfgang Denk [SMTP:wd@denx.de]
Sent:	Tuesday, January 15, 2002 9:37 AM
To:	svacca@valcom.com
Subject:	Re: mpc860 vs. mpc860T

In message <01C19DA6.994D3370.svacca@valcom.com> you wrote:
>
> I did a complete search for CONFIG_8xx_CPU6, and
> truncated variations, in my mpc8xx-2.2.13 kernel, and
> could not find it.  It doesn't show up as a cfg option either.
> Even a grep on CONFIG_8xx doesn't show anything
> resembling that.  Could it be in there and accessible
> in an alternative way?

Sorry, I never checked RH's sources (which are pretty old anyway);  I
have no idea if they provide alternative configuration options.

You can grab some  of  the  other  8xx  enabled  source  trees  (like
MontaVista's  or  ours - see ftp://ftp.denx.de/pub/LinuxPPC/usr/src/)
and extract the necessary changes (or compare if they _are_ available
in your RH code, but under a different name.

There are only 4 files affected:

	arch/ppc/8xx_io/Config.in
	arch/ppc/kernel/head.S
	arch/ppc/kernel/time.h
	include/asm-ppc/pgtable.h

Hope this helps,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
This is now.  Later is later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
