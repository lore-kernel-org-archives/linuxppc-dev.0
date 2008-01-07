Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6F519DDE1E
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 Jan 2008 22:18:12 +1100 (EST)
Message-ID: <47820A60.2040500@scram.de>
Date: Mon, 07 Jan 2008 12:17:52 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: rmcguire@videopresence.com
Subject: Re: 83xx, ucc_geth, kernel 2.6.23, IP-Config: No network devices
References: <mailman.1.1198890002.24584.linuxppc-embedded@ozlabs.org><000001c84b47$50b0e2b0$6405a8c0@absolut>	<20071231111443.4c6d8691@kernel.crashing.org>
	<000001c8511b$bc0c03d0$6405a8c0@absolut>
In-Reply-To: <000001c8511b$bc0c03d0$6405a8c0@absolut>
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

Hi Russell,

> I would appear all the appropriate entries are in the .dts file
> for each the different parts (mdio, ucc_geth, ucc_geth_mdio, phy0).
> 
> And yet still no probe functions get called for any of those drivers?

Do you export the subtree using of_platform_bus_probe()?

Thanks,
Jochen
