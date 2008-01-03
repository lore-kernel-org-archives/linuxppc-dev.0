Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 76F96DDF33
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jan 2008 06:18:49 +1100 (EST)
Message-ID: <477D3507.5090906@freescale.com>
Date: Thu, 03 Jan 2008 13:18:31 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
References: <11981089894052-git-send-email-timur@freescale.com>	
	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>	
	<9e4733910801010942y47e4cdbfge5e0d3e44ab96760@mail.gmail.com>	
	<477BAB67.4080003@freescale.com>	
	<fa686aa40801020812o471e18e6u9fe20676d320e958@mail.gmail.com>	
	<477D24AA.4050804@freescale.com>	
	<fa686aa40801031017n42f6fbf1nb2da5097ef13cf3c@mail.gmail.com>	
	<477D2F52.7090306@freescale.com>
	<fa686aa40801031113od68e2a3m6cb60b8fa6f26c17@mail.gmail.com>
In-Reply-To: <fa686aa40801031113od68e2a3m6cb60b8fa6f26c17@mail.gmail.com>
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
> On 1/3/08, Scott Wood <scottwood@freescale.com> wrote:
>> I'd just link in both directions, and let software follow it in
>> whichever direction it prefers.
> 
> Gah!  Don't do that!  Then you need to maintain both directions in the
> dts file.  Software is good at generating reverse mappings.

Software is, however, lousy at correctly wading through 
poorly-structured data (which device trees are full of) to figure out 
how to locate the link it wants to follow backwards.

-Scott
