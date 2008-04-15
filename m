Return-Path: <tur@semihalf.com>
Received: from semihalf.com (semihalf.com [206.130.101.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AED02DE203
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 20:35:56 +1000 (EST)
Message-ID: <480484C5.5040907@semihalf.com>
Date: Tue, 15 Apr 2008 12:34:45 +0200
From: Bartlomiej Sieka <tur@semihalf.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Please pull linux-2.6-mpc52xx.git
References: <fa686aa40803171443q7a53f0balbb49740116c6552@mail.gmail.com>	
	<20080317222836.AFA66241A2@gemini.denx.de>	
	<fa686aa40803171643y7db21cadsc454a713ba6c4342@mail.gmail.com>	
	<47E938A8.9000103@semihalf.com>	
	<fa686aa40803251151p457a2295w449222654be4d0d1@mail.gmail.com>	
	<47F22C9A.4050501@semihalf.com> <47F60D5D.5090402@semihalf.com>
	<fa686aa40804040911o63e2e3efg2d9a74fff082fb16@mail.gmail.com>
In-Reply-To: <fa686aa40804040911o63e2e3efg2d9a74fff082fb16@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Grant,

Grant Likely wrote:
> On Fri, Apr 4, 2008 at 5:13 AM, Bartlomiej Sieka <tur@semihalf.com> wrote:
>> Bartlomiej Sieka wrote:
>>
>>> Hi Grant,
>>>
>>> Grant Likely wrote:
>>>> I'm thinking 'optimized' defconfigs should go into a subdirectory.
>>> This requires a change to the top-level Makefile and shepherding this
>>> change upstream. Could we perhaps try to avoid this by having optimized
>>> defconfigs in the form of, for example:
> 
> I don't think changes are required to put them in a subdir:
> 
> $ mkdir arch/powerpc/configs/optimized
> $ cp arch/powerpc/configs/mpc5200_defconfig
> arch/powerpc/configs/optimized/lite5200_defconfig
> $ make optimized/lite5200_defconfig
> 
> This works for me.

Yes, this indeed works.

I'm about to post a patch that adds board-specific defconfigs for 52xx
boards -- could you review it and push the changes upstream via your 
tree? Thanks in advance.

Regards,
Bartlomiej
