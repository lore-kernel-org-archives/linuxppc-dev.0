Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8F645DDF11
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jan 2008 05:28:03 +1100 (EST)
Message-ID: <477D296A.6040202@freescale.com>
Date: Thu, 03 Jan 2008 12:28:58 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
References: <11981089894052-git-send-email-timur@freescale.com>	
	<9e4733910801012027p4be16b92r43af773f4e5ae531@mail.gmail.com>	
	<477BADF5.9060003@freescale.com>	
	<fa686aa40801020828u5103d09cn2aa5eab7dda2fcff@mail.gmail.com>	
	<477D25F4.6020700@freescale.com>
	<fa686aa40801031025r10c31ce6x203755fe532f0c88@mail.gmail.com>
In-Reply-To: <fa686aa40801031025r10c31ce6x203755fe532f0c88@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:

> Make the compatible property tell you!  :-)  If it's connected to an
> I2S codec, then it could be compatible = "fsl,mpc8610-ssi,i2s".  Or
> for AC7, compatible = "fsl,mpc8610-ssi,ac97"

That won't work.  There are too many variations.  I think a separate property 
just makes more sense.  Frankly, I don't see what's wrong with it.



-- 
Timur Tabi
Linux Kernel Developer @ Freescale
