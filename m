From: "Sanjay Kumar" <skumar@giga-stream.de>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: m8260_cpm_dpfree( )
Date: Mon, 28 Jul 2003 15:15:07 +0200
MIME-Version: 1.0
Message-ID: <FKEJLMJFECLAHOKCGJFPKEFGCBAA.skumar@giga-stream.de>
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi !

I have few questions regarding MPC8260 ATM device driver.

1. where can I get m8260_cpm_dpfree() function implementation ?
2. For using the m8260_cpm_dpalloc(uint size, uint align) function I have
included
   #include <asm/cpm_8260.h> and having CC_OPTION
 -D__KERNEL__ -DMODULE  -DCONFIG_8260
    in my Makefile. But when I tried to load this driver on
motorola-mtx-ppc_7xx target
    it gives unresolved symbol for m8260_cpm_dpalloc(). I have kernel
Monatavista 2.4.17
    Anything I am missing in this case ?
3. I am including file #include <asm/mpc8260.h> for using define
request_8xxirq.But I am not
   able to include this define.
4. I am including file  <asm/irq.h> for using define SIU_INT_FCC1. But I
am not able
   to include this define.
  Do I am missing something ? I have same CC_OPTION as mentioned above.
Does anything matter
  with kernel version?

 Any idea will be highly appreciated.

regards,
sanjay

 ==============================================================
 Sanjay Kumar                        skumar@giga-stream.de
 GIGA-STREAM UMTS Technologies GmbH  Tel: +49 (07243) 94976-119
 Im Ermlisgrund 8                    Fax: +49 (07243) 94976-100
 76337 Waldbronn
 ==============================================================

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
