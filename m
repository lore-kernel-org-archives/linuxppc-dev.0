Message-ID: <3C164F4B.E9A4FCA2@seranoa.com>
Date: Tue, 11 Dec 2001 13:24:11 -0500
From: Andrew Dixon <andrew.dixon@seranoa.com>
MIME-Version: 1.0
To: ppclist <linuxppc-embedded@lists.linuxppc.org>
Subject: r3 and bd_t
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All -

I'm trying to boot linux on an sbc8260 using PPCBoot.  (Linux 2.4.16 and
PPCBoot 1.1.2)  PPCBoot passes a data structure (bd_t) with a lot of
board information in it.  The way that this is supposed to work (I
think, please correct me if I'm wrong) is that PPCBoot leaves the
address of the data structure in r3 and one of the first things that
linux should do is to copy or obtain this information somehow.  So, my
question is this: does anyone know where this happens in the code?  I've
been looking in arch/ppc/kernel/setup.c and this looks like where it
should happen but I don't see it.

Any help would be greatly appreciated.

Thanks,
Andy

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
