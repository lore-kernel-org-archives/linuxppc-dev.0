Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A402D679F8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Feb 2006 07:44:03 +1100 (EST)
In-Reply-To: <20060220201504.C5289353C11@atlas.denx.de>
References: <20060220201504.C5289353C11@atlas.denx.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <80a18d524ef11e64f291f6b0d4f877f8@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: SCCx UART status on 8xx 
Date: Mon, 20 Feb 2006 15:43:51 -0500
To: Wolfgang Denk <wd@denx.de>
Cc: =?ISO-8859-1?Q?Bj=F6rn_=D6stby?= <Bjorn.Ostby@combitech.se>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Feb 20, 2006, at 3:15 PM, Wolfgang Denk wrote:

> All UARTS (up to 2 x SMC + 4 x SCC, depending on CPU  model)  can  be
> used with our tree, including hardware handshake.

Except that you have to be careful about BRG allocation.  At most,
the 8xx will have 4 BRGs, some only have 2.  There have been various
implementations to work with this, some forced the BRGs to be
multiply mapped (where more than one UART had to run at the same rate)
while others silently returned errors and the UARTs were non-functional
although appeared for use.

Thanks.

	-- Dan
