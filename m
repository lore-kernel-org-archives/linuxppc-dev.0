Message-ID: <3D6D7B65.DC29B971@taikebj.com.cn>
Date: Thu, 29 Aug 2002 09:39:49 +0800
From: caokai <tk19@taikebj.com.cn>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: 8xx's IMMR can not be 0x12200000?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


     I am porting a custom mpc8xx board . using PPCBOOT + MontaVista
Linux 2.1(2.4.17).
     I found that if I set IMMR to 0x12200000 in PPCBOOT and Linux. The
linux kernel can startup,but  will stop in exece("/sbin/init").I use a
bdi2000 and found that it deadloop in do_page_fault.
     But if I set IMMR to 0xFF000000, the linux kernel can work good.
     I think this limitation must be somewhere in the
arch/ppc/kernel/head_8xx.S.right?

regards
caokai


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
