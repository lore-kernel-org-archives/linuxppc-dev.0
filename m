Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <01C19DA2.0031A1C0.svacca@valcom.com>
From: Steven Vacca <svacca@valcom.com>
Reply-To: "svacca@valcom.com" <svacca@valcom.com>
To: "LinuxEmbeddedMailList (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: mpc860 vs. mpc860T
Date: Tue, 15 Jan 2002 08:52:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


OK, here goes.

My 860T rev is:  duht-duhduh-duuuuuhh: XPC860TZP50B3  :>(

I guess that means I'll need some workarounds.

My embedded linux kernel is Redhat's mpc8xx-2.2.13, so
maybe porting in some workarounds might not be too painful.
Could I please get access to your workarounds, Magnus?

Thanks,

Steven



-----Original Message-----
From:	Magnus Damm [SMTP:damm@opensource.se]
Sent:	Tuesday, January 15, 2002 4:56 AM
To:	svacca@valcom.com
Subject:	Re: mpc860 vs. mpc860T

Early 860T cpu:s have lots of silicon bugs.
Check out the revision information and the errata.

If you have a 860TB3 or earlier you need workarounds.

Funny notice:
On one of the first 860T revisions it wasn't possible to
use the CPM and the fec at the same time...

One other problem I remember was related to SPR:s and
trashed cache...

I do have workarounds in my kernel, but they are for a
2.2.16-kernel.

Good luck /

Magnus

Steven Vacca wrote:
>
> I have 2 bds., the BD #1 is custom designed and based very
> closely on the design of the BD #2.  The main difference
> is BD #1 uses an mpc860T and BD #2 uses an mpc860.
>
> Both have 32 Meg DRAM, 50MHz.
>
> I can use the exact same Flash Boot code on each,
> and download the exact same Linux kernel and app to each.
>
> BD #2 (mpc860) works perfectly, all the way thru to the app
> executing threads, etc.
>
> BD #1 (mpc860T) works up until at various points between when
> the kernel initializes itself, and the app execution begins, it gets
> exception errors, usually something similar to the following:
>
>   Kernel panic: kernel access of bad area pc c0023634 lr c00235ec
>                       address 813F004C tsk kswapd/5
> or,
>
>   Kernel panic: ramdisk: request list destroyed
>
> Does anyone know of any differences between the 2 CPU's, other than
> the mpc860T's internal FEC section and the MII interface on port D, that
> might cause such problems?
>
> Thanks,
>
> Steven
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
