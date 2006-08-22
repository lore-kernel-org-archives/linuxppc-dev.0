Return-Path: <olaf@ibook.aepfle.de>
Received: from natreg.rzone.de (natreg.rzone.de [81.169.145.183])
	by ozlabs.org (Postfix) with ESMTP id 03E6F67C35
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 08:36:27 +1000 (EST)
Date: Wed, 23 Aug 2006 00:35:29 +0200
From: Olaf Hering <olaf@aepfle.de>
To: dtutty@porchlight.ca
Subject: Re: boot problems on pseries
Message-ID: <20060822223528.GA7546@aepfle.de>
References: <20060820170055.GA8958@hooton> <20060821145624.GA30464@aepfle.de>
	<20060822165023.GA4807@hooton>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060822165023.GA4807@hooton>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 22, dtutty@porchlight.ca wrote:

> Boot failures:
> 
> 	1.	CD not recognized as bootable, so use OF manually.
> 	2.	OF manually will boot yaboot.
> 	3.	yaboot doesn't find its config in the /etc directory
> 		of the cd, nor in the / directory of the CD with the
> 		yaboot executable.
> 	4.	when manually from yaboot attempt to boot a kernel
> 		image, get either:
> 			a)	CLAIMED	FAILED	
> 			b)	incorrect ELF format
> 				(something like that, I wasn't there
> 				when the tech got that one)
> 			c)	not a valid kernel image
> 
> At no point do I get any indication that the linux kernel has had a
> chance to try booting; it doesn't get that far.

I havent seen that sort of error, maybe a bad burn.

> I'll look at SuSE and see if there's a free-download of a boot floppy.

http://mirrors.kernel.org/opensuse/distribution/SL-stable/iso/SUSE-Linux-10.1-GM-ppc-mini.iso
http://mirrors.kernel.org/opensuse/distribution/SL-OSS-factory/inst-source/boot/boot.ppc.iso

You can try to boot the inst32 file via the network. Make sure to fix
the ARP entry for the H50 on the tftp server, like 'arp -s 1.2.3.4 MAC'
yaboot.ibm can also be used. Rename yaboot.cnf to yaboot.conf so yaboot
will be able to download it.
