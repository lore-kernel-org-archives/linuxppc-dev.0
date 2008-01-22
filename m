Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4CCCEDDE38
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 08:22:54 +1100 (EST)
Message-ID: <47965E83.7050305@freescale.com>
Date: Tue, 22 Jan 2008 15:22:11 -0600
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 1/2] Add localbus and flash nodes to mpc8641_hpcn.dts
References: <1201019917.5716.154.camel@rhino> <1201032819.5716.170.camel@rhino>
	<47965506.9070305@freescale.com>
	<65C80AAA-CC92-41BC-86FC-D74A2C7D5059@kernel.crashing.org>
In-Reply-To: <65C80AAA-CC92-41BC-86FC-D74A2C7D5059@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> I'm assuming he's listed CS1, CS2, and CS3 even though we don't have a 
> children yet.  (second flash chip, CF, and pixis).
> 
> - k

OK -- I just wasn't sure if you wanted the other
CS entries for nodes that weren't actually present yet.

jdl
