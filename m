Return-Path: <gjalt007@chello.nl>
Received: from viefep19-int.chello.at (viefep18-int.chello.at [213.46.255.22])
	by ozlabs.org (Postfix) with ESMTP id 62DC3DE044
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Oct 2007 20:46:17 +1000 (EST)
Received: from [192.168.2.200] (really [80.56.196.199])
	by viefep15-int.chello.at
	(InterMail vM.7.08.02.00 201-2186-121-20061213) with ESMTP
	id <20071009102818.ZXGH19118.viefep15-int.chello.at@[192.168.2.200]>
	for <linuxppc-embedded@ozlabs.org>; Tue, 9 Oct 2007 12:28:18 +0200
Message-ID: <470B5694.2040100@chello.nl>
Date: Tue, 09 Oct 2007 12:23:16 +0200
From: Theo Gjaltema <gjalt007@chello.nl>
MIME-Version: 1.0
To: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: reboot of mpc8270 sometimes fails
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

hi,

I have an MPC8270 based board with linux 2.4.25 kernel (denx) and 
ramdisk (subset of ELDK3.1.1).
The system works fine, but sometimes after performing a reboot the 
system hangs after terminating the kernel and uboot doesn't come up.
Does someone have a clue about this?

Thanks,
   Theo.
