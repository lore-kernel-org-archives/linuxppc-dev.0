Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CB6D5DDF60
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 10:42:57 +1100 (EST)
Message-ID: <4786A37C.2040905@freescale.com>
Date: Thu, 10 Jan 2008 17:00:12 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3] [POWERPC] Update MPC8610 HPCD to support audio drivers
References: <12000050651235-git-send-email-timur@freescale.com>	<12000050664035-git-send-email-timur@freescale.com>
	<fa686aa40801101452q608907f3rf6f98a5d091d09d9@mail.gmail.com>
In-Reply-To: <fa686aa40801101452q608907f3rf6f98a5d091d09d9@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: olof@lixom.net, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Timur Tabi <timur@freescale.com>, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
>> +                dma@21300 {
>> +                        #address-cells = <1>;
>> +                        #size-cells = <1>;
>> +                        compatible = "fsl,mpc8610-dma", "fsl,eloplus-dma";
>> +                        cell-index = <0>;
>> +                        reg = <21300 4>; /* DMA general status register */
>> +                        ranges = <0 21100 200>;
>> +
>> +                        dma-channel@0 {
>> +                               compatible = "fsl,mpc8610-dma-channel",
>> +                                       "fsl,eloplus-dma-channel";
> 
> Nit: you probably don't need the compatible property for these channel
> nodes since they are 100% dependent on the parent for describing the
> behaviour.

The compatible property in the child nodes gives the driver the option 
of matching the channel rather than the whole thing.

-Scott
