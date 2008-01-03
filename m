Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3C549DDED6
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jan 2008 05:54:18 +1100 (EST)
Message-ID: <477D2F52.7090306@freescale.com>
Date: Thu, 03 Jan 2008 12:54:10 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
References: <11981089894052-git-send-email-timur@freescale.com>	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>	<9e4733910801010942y47e4cdbfge5e0d3e44ab96760@mail.gmail.com>	<477BAB67.4080003@freescale.com>	<fa686aa40801020812o471e18e6u9fe20676d320e958@mail.gmail.com>	<477D24AA.4050804@freescale.com>
	<fa686aa40801031017n42f6fbf1nb2da5097ef13cf3c@mail.gmail.com>
In-Reply-To: <fa686aa40801031017n42f6fbf1nb2da5097ef13cf3c@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On 1/3/08, Timur Tabi <timur@freescale.com> wrote:
>> Grant Likely wrote:
>>
>>> Why not be a child of the i2c bus with a phandle to the ssi bus?
>> Because when I probe the SSI node, I want to know what the attached codec is.
>>   So if anything, I would need a pointer from the SSI bus *to* the respective
>> child on the I2C bus.
> 
> That's fine too (it's what is done with Ethernet PHYs).  My preference
> is the other way around, but it's not a big issue in this case.

I'd just link in both directions, and let software follow it in 
whichever direction it prefers.

-Scott
