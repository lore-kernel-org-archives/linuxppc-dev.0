Return-Path: <bounces@nabble.com>
Received: from talk.nabble.com (www.nabble.com [72.21.53.35])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 86307DDFA0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Apr 2007 01:12:04 +1000 (EST)
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50) id 1Hg0Cu-0003Nb-H2
	for linuxppc-embedded@ozlabs.org; Mon, 23 Apr 2007 08:12:00 -0700
Message-ID: <10142161.post@talk.nabble.com>
Date: Mon, 23 Apr 2007 08:12:00 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-embedded@ozlabs.org
Subject: Re: zImage.elf loads but does not start
In-Reply-To: <10079346.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <10079346.post@talk.nabble.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I have revised the xparameters_ml403.h and the setup of the FPGA part. I have
found that the interrupt for the RS232 was not configured. Right now I was
able to come to the point when the kernel was uncompressed but it did not
start:


loaded at:     00400000 004F9138

board data at: 004F7120 004F7138

relocated to:  00404064 0040407C

zimage at:     00404DF1 004F6BBB

avail ram:     004FA000 04000000



Linux/PPC load: console=ttl0,9600 ip=129.129.129.29 root=/dev/ram rw

Uncompressing Linux...done.

Now booting the kernel




Does anybody has an idea what could be wrong?

Best Regards

Mirek
-- 
View this message in context: http://www.nabble.com/zImage.elf-loads-but-not-starts-tf3607582.html#a10142161
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
