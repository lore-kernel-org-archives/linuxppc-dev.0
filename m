Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id C26EA67A65
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Jun 2006 05:56:42 +1000 (EST)
In-Reply-To: <F795765B112E7344AF36AA9112796415019ED1C6@xmb-sjc-212.amer.cisco.com>
References: <F795765B112E7344AF36AA9112796415019ED1C6@xmb-sjc-212.amer.cisco.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <95CA7BE8-4744-4C03-AD48-978B7F6ED441@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: zero-copy support on TSEC?
Date: Mon, 26 Jun 2006 14:56:56 -0500
To: Bizhan Gholikhamseh ((bgholikh)) <bgholikh@cisco.com>
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


On Jun 26, 2006, at 13:26, Bizhan Gholikhamseh ((bgholikh)) wrote:

> Hi ALL,
> We have developed a custom board mother board based on
> MPC8541 processor running Linux 2.6.11.
>
> In our system, most of the ingress UDP packets  are retransmitted
> with one modification to data portion of the packet (one byte). As you
> see there are many copy overhead due to copy from system to userland
> and vise versa which has impacted our system performance.
>
> Is there a zero-copy support for TSEC
> to eliminate the buffer copy from kernel to userland and vise versa?


I'm not sure there's any way, at present, in Linux to avoid the user/ 
kernel copying.  You might want to ask on the netdev@vger.kernel.org  
list, though.

Andy
