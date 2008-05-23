Return-Path: <john.bonesio@xilinx.com>
Received: from outbound5-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id BDEEEDE00F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 May 2008 11:09:15 +1000 (EST)
Subject: Re: APU FPU in Virtex ppc405
From: John Bonesio <john.bonesio@xilinx.com>
To: dhlii@dlasys.net
In-Reply-To: <4835FC73.5080102@dlasys.net>
References: <4835FC73.5080102@dlasys.net>
Content-Type: text/plain
Date: Thu, 22 May 2008 18:09:08 -0700
Mime-Version: 1.0
Message-Id: <20080523010910.1976B408066@mail161-dub.bigfish.com>
Cc: Thomas Werne <thomas.a.werne@jpl.nasa.gov>,
	"A. Nolson" <alohanono@gmail.com>,
	Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>,
	Shanyuan Gao <sygao.research@gmail.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

My understanding is that with the fpu on the ppc405 (not ppc440), the
processor clock rate had to be reduced for the fpu to work. This ended
up negating much of the performance benefits of using the fpu.

I don't know the specifics offhand, but Xilinx answer records can be
searched. Hopefully I'm wrong, and there can still be a benefit to using
the ppc405 fpu.

- John


On Thu, 2008-05-22 at 19:06 -0400, David H. Lynch Jr. wrote:
>    Were the issues associated with getting the Xilinx Floating point APU
> working with Linux completely resolved ?
>     Is there a git tree or patch collection with the appropriate patches
> etc ?
> 
> 
> 

________________________________________________________________________

John Bonesio
Commercial Linux Solutions
john.bonesio@xilinx.com
(408) 879-5569

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
