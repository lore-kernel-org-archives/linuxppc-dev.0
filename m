Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <01C19DA6.994D3370.svacca@valcom.com>
From: Steven Vacca <svacca@valcom.com>
Reply-To: "svacca@valcom.com" <svacca@valcom.com>
To: "LinuxEmbeddedMailList (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: mpc860 vs. mpc860T 
Date: Tue, 15 Jan 2002 09:25:39 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I did a complete search for CONFIG_8xx_CPU6, and
truncated variations, in my mpc8xx-2.2.13 kernel, and
could not find it.  It doesn't show up as a cfg option either.
Even a grep on CONFIG_8xx doesn't show anything
resembling that.  Could it be in there and accessible
in an alternative way?

Steven

-----Original Message-----
From:	Wolfgang Denk [SMTP:wd@denx.de]
Sent:	Tuesday, January 15, 2002 9:01 AM
To:	svacca@valcom.com
Subject:	Re: mpc860 vs. mpc860T

Dear Steven,

in message <01C19DA2.0031A1C0.svacca@valcom.com> you wrote:
>
> My 860T rev is:  duht-duhduh-duuuuuhh: XPC860TZP50B3  :>(
>
> I guess that means I'll need some workarounds.

Right.

> My embedded linux kernel is Redhat's mpc8xx-2.2.13, so
> maybe porting in some workarounds might not be too painful.
> Could I please get access to your workarounds, Magnus?

Ummm... the CONFIG_8xx_CPU6 kernel  configuation  option  (workaround
for  CPU6  Silicon  Errata  (860  Pre  Rev.  C  et  al.)) was already
available with 2.2.13 kernels;  you  may  check  it  RH  bothered  to
include it. If so, just enable it.

Hope that helps,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Lead me not into temptation... I can find it myself.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
