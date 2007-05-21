Return-Path: <monodhs@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id D39DBDDE0D
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 09:44:14 +1000 (EST)
Message-ID: <46522EF1.6030804@gmx.de>
Date: Tue, 22 May 2007 01:44:49 +0200
From: =?UTF-8?B?Q2hyaXN0aWFuIELDtmhtZQ==?= <monodhs@gmx.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Interrupt routing broken on TiBook IV with 2.6.21.x ?
References: <4650E27B.3020401@gmx.de>	
	<1179712614.32247.597.camel@localhost.localdomain>	
	<4651FC48.8000002@gmx.de>	
	<1179785502.32247.748.camel@localhost.localdomain>	
	<4652219D.6050308@gmx.de>
	<1179789304.32247.760.camel@localhost.localdomain>
In-Reply-To: <1179789304.32247.760.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

> I'm not sure what you are talking about here. DMA mapping has existed in
> linux for years.

I do admit that it's been a while since that last look ;)  The topic came up
when discussing PCI and bus systems in general with micro/real-time kernel
people whom I assumed to be experts in this since they had Linux kernels
running on top of their scheduling scheme.  As it turned out, using an
abstraction such as a DMA map was a totally new concept to them.  They
even questioned the usefulness of such an approach.


Cheers,
Christian
