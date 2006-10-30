Return-Path: <tnt@246tNt.com>
Received: from outmx008.isp.belgacom.be (outmx008.isp.belgacom.be
	[195.238.5.235])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7B54267F2C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Oct 2006 10:18:13 +1100 (EST)
Received: from outmx008.isp.belgacom.be (localhost [127.0.0.1])
	by outmx008.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k9UNI5nm028054
	for <linuxppc-embedded@ozlabs.org>; Tue, 31 Oct 2006 00:18:05 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45468828.8010200@246tNt.com>
Date: Tue, 31 Oct 2006 00:18:00 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Dale Farnsworth <dale@farnsworth.org>
Subject: Re: [PATCH 1/2] Add MPC52xx Interrupt controller support
	for	ARCH=powerpc
References: <20061030174724.7155.qmail@farnsworth.org>
In-Reply-To: <20061030174724.7155.qmail@farnsworth.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dale Farnsworth wrote:
> In article <200610292310.k9TNAHXZ013852@post.webmailer.de> Nicolas wrote:
>   
>> This patch add MPC52xx Interrupt controller for ARCH=powerpc.
>>
>> It includes the main code in arch/powerpc/sysdev/ ad well as an header
>> file in include/asm-powerpc.
>>
>> Signed-off-by: Nicolas DET <nd@bplan-gmbh.de>
>>     
>
> NAK.
>
> Two requests:
>   1.  Please include patches inline so that they may be easily reviewed.
>   2.  Please do not remove copyright lines from files you modify.
>   
Indeed.



Dale Farnsworth wrote:
> Wow, the source code size sure ballooned in this revision.
>
> I'd like to see us go the other direction, with something like the
> following (untested code).
>   

Well that's kind of a contradiction with what benh asked (separate IC
chips).

> static inline void io_be_setbit(u32 __iomem *addr, int bitno)
> {
> 	out_be32(addr, in_be32(addr) | 1 << bitno);
> }
>
> static inline void io_be_clrbit(u32 __iomem *addr, int bitno)
> {
> 	out_be32(addr, in_be32(addr) & ~(1 << bitno));
> }
>   
Those could still be used to cleanup a little the code.


    Sylvain
