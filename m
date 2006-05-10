Return-Path: <netstv@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by ozlabs.org (Postfix) with ESMTP id B99C3679F6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 May 2006 04:04:12 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id e30so2149456pya
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 May 2006 11:04:08 -0700 (PDT)
Message-ID: <b4b98b690605101104s424fb445l731f3d705d66d55e@mail.gmail.com>
Date: Wed, 10 May 2006 11:04:08 -0700
From: "Steve Iribarne (GMail)" <netstv@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Need help debugging
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

ok, so I've got my BDI2000 working and talking to my 8260.
I read as much info as I could find on this but I still think I'm
missing something.

I have a uBoot image and I wait for the system to download my kernel.=20
Not through the BDI, I just let the uBoot boot image do it the normal
way.  I start it by telling the BDI to "go".

Then what I want to do is connect to my linux kernel after the kernel
is up and running so I do:

(gdb) target remote bdi:2001
Remote debugging using bdi:2001
0xc000c9cc in ??()
(gdb)

Then I add my symbol table.

(gdb) add-symbol-file vmlinux 0xc0000000

at that point I get a reset.

I turn off the software watchdog in the BDI config file.  Is there
something I am missing?

Thanks in advance.

-stv
