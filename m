Return-Path: <mustafa.cayir@bte.mam.gov.tr>
Received: from itri.bte.mam.gov.tr (bte.mam.gov.tr [193.140.75.15])
	by ozlabs.org (Postfix) with SMTP id 3C006DE64B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Aug 2008 19:42:47 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-9"
Subject: Linux booting problem MPC7457 based board with U-boot 1.1.4 and Linux
	2.6.12.6
Date: Tue, 26 Aug 2008 12:28:11 +0300
Message-ID: <7B9A8FF57DBB524190E98CABF6E56F07D2C3F4@itri.bte.mam.gov.tr>
From: =?iso-8859-9?Q?Mustafa_Cay=FDr?= <mustafa.cayir@bte.mam.gov.tr>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I have a custom MPC7457 based board which has been running U-boot 1.1.4. =
I am trying to port Linux 2.6.12.6 .

When booting, Linux hangs when calling "call_setup_cpu" function.

arch\ppc\kernel\head.S

/*
 * Call setup_cpu for CPU 0 and initialize 6xx Idle
 */
	bl	reloc_offset
	li	r24,0			/* cpu# */
	bl	call_setup_cpu		/* Call setup_cpu for this CPU */


Regards.
