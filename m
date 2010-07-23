Return-Path: <subrata@linux.vnet.ibm.com>
Subject: [next-20100722] drivers/input/serio/i8042.ko undefined error & Bad
	Relocations warning
From: Subrata Modak <subrata@linux.vnet.ibm.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain
Date: Fri, 23 Jul 2010 15:45:12 +0530
Message-Id: <1279880113.11936.7.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	linux-next <linux-next@vger.kernel.org>,
	Paul Mackerras <paulus@au1.ibm.com>, "divya.vikas" <divya.vikas@in.ibm.com>
Reply-To: subrata@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With linux-next-20100722 on Power7 and allmodconfig, i get the following
undefined error and Bad relocation warning:

ERROR: "of_i8042_kbd_irq" [drivers/input/serio/i8042.ko] undefined!
ERROR: "of_i8042_aux_irq" [drivers/input/serio/i8042.ko] undefined!

...
and
...

WARNING: 3 bad relocations
c000000000008590 R_PPC64_ADDR32    .text+0x4000000000008460
c000000000008594 R_PPC64_ADDR32    .text+0x4000000000008598
c000000000add890 R_PPC64_ADDR64    __crc_softirq_work_list

I reported the above on 2.6.35-rc5 alone few days back:
http://marc.info/?t=127919383300002&r=1&w=2,

However,
c000000000add890 R_PPC64_ADDR64    __crc_softirq_work_list

is newly seen apart from:
c000000000008590 R_PPC64_ADDR32    .text+0x4000000000008460
c000000000008594 R_PPC64_ADDR32    .text+0x4000000000008598

Regards--
Subrata
