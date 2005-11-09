Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BA2A6686C7
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Nov 2005 20:02:32 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20051109072228.GA7983@pb15.lixom.net>
References: <20051109072228.GA7983@pb15.lixom.net>
Content-Type: text/plain
Date: Wed, 09 Nov 2005 20:00:55 +1100
Message-Id: <1131526855.24637.67.camel@gaston>
Mime-Version: 1.0
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc: add support for new powerbooks
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Enablement patch for the new PowerBooks (late 2005 edition).
> 
> This enables the ATA controller, Gigabit ethernet and basic AGP setup.
> Bluetooth works out-of-the box after running hid2hci.
> 
> Still remaining is to get the touchpad to work, the simple change of
> just adding the new USB ids isn't enough.
> 
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
