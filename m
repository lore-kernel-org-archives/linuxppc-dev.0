Return-Path: <adams.ppc@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 56E44DDE22
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Aug 2008 15:12:53 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so119661yxg.39
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Aug 2008 22:12:52 -0700 (PDT)
Message-ID: <4a21eaea0808272212y6be97789nb6b94dd1d4987881@mail.gmail.com>
Date: Wed, 27 Aug 2008 22:12:51 -0700
From: "bhanu jampala" <adams.ppc@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: cpm_dpalloc questions
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Guys,

I am working on MCC HDLC controller on MCC8260. I have two important questions:

1. What is the range of DPRAM from which the cpm_dpalloc allocates memory?
    How does the cpm_dpalloc work?
    I need this because, I need to reserve the DPRAM memory for MCC2
from (128 * 60) to (255 * 60)
    for channels ranging from 128 - 255.

2. PROFF_SMC1 pointer placed at 0 , 64 offsets. is this not an area of
MCC1 controller?
    how if I want to use the MCC channel on MCC1.

 In file include/asm-powerpc/cpm2.h.

 /* The SMCs are relocated to any of the first eight DPRAM pages.
  * We will fix these at the first locations of DPRAM, until we
  * get some microcode patches :-).
  * The parameter ram space for the SMCs is fifty-some bytes, and
  * they are required to start on a 64 byte boundary.
  */
 #define PROFF_SMC1      (0)
 #define PROFF_SMC2      (64)

Regards,
Adams
