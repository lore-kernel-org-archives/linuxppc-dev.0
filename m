Return-Path: <v.selvamuthukumar@gmail.com>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.235])
	by ozlabs.org (Postfix) with ESMTP id 78547DDEE7
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Jul 2008 22:14:40 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id c8so2074576qbc.39
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Jul 2008 05:14:39 -0700 (PDT)
Message-ID: <790896390807140514r6074ec7j6d3eaf38787e3444@mail.gmail.com>
Date: Mon, 14 Jul 2008 17:44:38 +0530
From: "selvamuthukumar v" <v.selvamuthukumar@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: MPC8313 ERDB has proper interrupt mapping for TSEC?
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

From, arch/powerpc/boot/dts/mpc8313erdb.dts,

212                 enet0: ethernet@24000 {
                                   .
                                   .
219                         interrupts = <37 0x8 36 0x8 35 0x8>;
                                   .
                                   .
222                 };
223
224                 enet1: ethernet@25000 {
                                   .
                                   .
231                         interrupts = <34 0x8 33 0x8 32 0x8>;
                                   .
234                 };
235

But as per 8313 Reference manual interrups 32, 33, 34 are for
TSEC1@24000 and 35, 36, 37 are for TSEC2@25000. Any idea why interrupt
numbers are swapped for enet0 and enet1?

-- 
Selva
