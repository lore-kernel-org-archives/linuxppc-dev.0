Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 233E5DDE38
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Jan 2008 00:53:00 +1100 (EST)
Message-ID: <47822EAF.1000803@scram.de>
Date: Mon, 07 Jan 2008 14:52:47 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: rmcguire@videopresence.com
Subject: Re: 83xx, ucc_geth, kernel 2.6.23, IP-Config: No network devices
References: <mailman.1.1198890002.24584.linuxppc-embedded@ozlabs.org><000001c84b47$50b0e2b0$6405a8c0@absolut>	<20071231111443.4c6d8691@kernel.crashing.org>
	<000001c8511b$bc0c03d0$6405a8c0@absolut>
	<47820A60.2040500@scram.de>
	<000401c8512d$3b9d93a0$6405a8c0@absolut>
In-Reply-To: <000401c8512d$3b9d93a0$6405a8c0@absolut>
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

> Next question, I can see that 'quick' mods I have made to the Marvell driver
> are indeed matching up with the device ID that the Freescale MII device is
> pulling back from my 'National' part. <I'll make a real phy driver once I
> get this working>. I.e. I can see the phy_probe get called when this Id is
> registered.  You can see the extra debug messages above the National DP83865
> device registration, and the probe returns 0 for success I assume. <err =
> 0>.
> 
> I am still getting the "IP-Config: No network devices" error before the NFS
> boot tries to take place.

I would add some more debugging printk output to check where the device
initialisation fails. Or if the phy runs without any initialisation, you
could use the fixed-phy patches from Vitali Bordug and hardcode the speed and
duplex settings in the device tree until you real phy driver is finished.

thanks,
Jochen
