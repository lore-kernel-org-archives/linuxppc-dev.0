Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id A16E6B7B9A
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2009 06:08:57 +1100 (EST)
Date: Tue, 13 Oct 2009 12:09:12 -0700 (PDT)
Message-Id: <20091013.120912.186003446.davem@davemloft.net>
To: afleming@freescale.com
Subject: Re: [PATCH 0/8] gianfar: Add support for hibernation
From: David Miller <davem@davemloft.net>
In-Reply-To: <64B2BB18-32DC-4B98-95D6-F203F74040D5@freescale.com>
References: <20091012160000.GA32406@oksana.dev.rtsoft.ru>
	<20091012.235747.195783342.davem@davemloft.net>
	<64B2BB18-32DC-4B98-95D6-F203F74040D5@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Andy Fleming <afleming@freescale.com>
Date: Tue, 13 Oct 2009 12:22:38 -0500

> No, it was fine (though made unnecessary by other patches).  The BD
> has a union:
> 
>                 struct {
>                         u16     status; /* Status Fields */
>                         u16     length; /* Buffer length */
>                 };
>                 u32 lstatus;
> 
> so when you write "lstatus", you need to use the BD_LFLAG() macro, but
> when you write "status", you are just setting the status bits.

Indeed I missed that, thanks.
