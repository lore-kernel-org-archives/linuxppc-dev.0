Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B653D6817D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Aug 2005 00:36:13 +1000 (EST)
In-Reply-To: <9FCDBA58F226D911B202000BDBAD467302BEB8C6@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD467302BEB8C6@zch01exm40.ap.freescale.net>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f208ac7cfaf2da5ada26a6dd91dc27b8@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 30 Aug 2005 10:36:00 -0400
To: Li Tony-r64360 <Tony.Li@freescale.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
	Chu hanjin-r52514 <Hanjin.Chu@freescale.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc32 :Added PCI support for MPC83xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 29, 2005, at 11:02 PM, Li Tony-r64360 wrote:

> I think it is OK. The external interrupt can be edged. And it works 
> well in my board.

No, it can't.  PCI interrupts must be level sensitive because multiple
slots can share an interrupt.

Thanks.

	-- Dan
