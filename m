Return-Path: <gautran@mrv.com>
Received: from mailman.xyplex.com (mailman.xyplex.com [140.179.176.116])
	by ozlabs.org (Postfix) with ESMTP id 13FA968802
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Dec 2005 09:03:25 +1100 (EST)
Message-ID: <19EE6EC66973A5408FBE4CB7772F6F0A2105B5@ltnmail.xyplex.com>
From: "Autran, Guillaume" <gautran@mrv.com>
To: "'n_tbinh@yahoo.com '" <n_tbinh@yahoo.com>
Date: Wed, 30 Nov 2005 16:58:49 -0500
MIME-Version: 1.0
Content-Type: text/plain
Cc: "'linuxppc-embedded@ozlabs.org '" <linuxppc-embedded@ozlabs.org>
Subject: RE: Booting hangs after "Calibrating delay loop..."
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Binh Nguyen,

m8xx_setup.c moved in the recent 2.6 kernels to the syslib directory. I am
using the 2.6.14 and the external RTC works with the modification I gave
you.

The only other thing different is the initialization of the stamp variable
in time.c
I added the line: 'stamp = get_native_tbl();' right before
'last_jiffy_stamp(0) = tb_last_stamp = stamp;'

That's all.
Guillaume
