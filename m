Return-Path: <tur@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [62.233.211.107])
	by ozlabs.org (Postfix) with ESMTP id 24BA0DDEE0
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Mar 2007 02:16:21 +1100 (EST)
Message-ID: <45E6E888.9050508@semihalf.com>
Date: Thu, 01 Mar 2007 15:51:52 +0100
From: Bartlomiej Sieka <tur@semihalf.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: New Bestcomm/FEC patches (was: Re: [PATCH 0/7] MPC5200 and Lite5200b
	low power modes)
References: <20070301075323.GP4397@moe.telargo.com>
	<528646bc0703010625o92ff794ra5ba561b0861f2e3@mail.gmail.com>
In-Reply-To: <528646bc0703010625o92ff794ra5ba561b0861f2e3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On 3/1/07, Domen Puncer <domen.puncer@telargo.com> wrote:
>> Hi!
>>
>> Patches are based on latest mainline git tree + fec patches:
>> Fec_MPC5200_eth_driver.patch
>> Copy_bestcomm_support_files_into_arch_powerpc.patch
>> Make_FEC_work_on_the_lite5200.patch
>>
> ---8<---snip--->8---
>> I would appreaciate any comments, suggestions etc.
> 
> Cool, good work.  I'll try to do a proper review today.
> 
> Note on the Bestcomm stuff; the patches that you've referenced above
> will not be going into mainline.  They will be replaced by a new set
> of bestcomm/FEC patches, hopfully in the .22 timeframe, so your
> patches there will need some rework.

Hello,

I am working on porting arch/powerpc Linux to a custom MPC5200B-based 
board, and currently using your 52xx-dev branch. Is this new set of 
bestcomm/FEC patches already in any of your publicly available branches, 
or is it something completely fresh? I am seeing some networking 
problems, and would be interested in giving new patches a try.

Regards,
Bartlomiej
