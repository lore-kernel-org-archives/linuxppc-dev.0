Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 959D9DDE0D
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Apr 2009 01:01:45 +1000 (EST)
Message-Id: <85829FCA-D181-4992-9889-640B3329D023@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40904050739g219a9143v7bbc8cd673e52f4e@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] ASoC: fsl_dma: Pass the proper device for dma mapping
	routines
Date: Sun, 5 Apr 2009 09:59:12 -0500
References: <20090404183319.GA22203@oksana.dev.rtsoft.ru>
	<fa686aa40904042259h4c69e632x47a9e82393e8faef@mail.gmail.com>
	<20090405085243.GA16005@oksana.dev.rtsoft.ru>
	<fa686aa40904050739g219a9143v7bbc8cd673e52f4e@mail.gmail.com>
Cc: Becky Bruce <Becky.Bruce@freescale.com>, alsa-devel@alsa-project.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>,
	Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 5, 2009, at 9:39 AM, Grant Likely wrote:

> On Sun, Apr 5, 2009 at 2:52 AM, Anton Vorontsov
> <avorontsov@ru.mvista.com> wrote:
>> On Sat, Apr 04, 2009 at 11:59:39PM -0600, Grant Likely wrote:
>>> Becky & Kumar,
>>>
>>> Considering these fixups, would it be advisable for the dma  
>>> functions
>>> to climb up the dev->parent linkage when dma_ops are NULL?
>>
>> pcm->dev->parent doesn't point to the proper device, so
>> this won't work.
>
> What does it point to then?  IIUC, following the ->parent links should
> eventually get to a struct device that represents the platform or
> of_platform device for purposes of power management.
>
> BTW, I'm not NAKing your patch.  The patch looks fine to me.
>
> g.

No, I think we should just fix drivers.  There aren't that many SoC  
drivers and once they are fixed this will resolve itself.

- k
