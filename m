Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5DA99DDE0E
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 02:52:35 +1100 (EST)
Message-Id: <53D750AF-AC04-47F6-8537-4F17206CC279@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080124154001.GB23246@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 2/5] [POWERPC][NET] ucc_geth_mii and users: get rid of
	device_type
Date: Thu, 24 Jan 2008 09:52:14 -0600
References: <20080124151850.GA15190@localhost.localdomain>
	<20080124154001.GB23246@localhost.localdomain>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 24, 2008, at 9:40 AM, Anton Vorontsov wrote:

> device_type property is bogus, thus use proper compatible.
>
> Also change compatible property to "fsl,ucc-mdio".
>
> Per http://ozlabs.org/pipermail/linuxppc-dev/2007-December/048388.html
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

can we look at using "fsl,gianfar-mdio" ?  Meaning my understanding  
the programming model for the UCC mdio is identical to gianfar MDIO  
programming.

- k
