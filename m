Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ED14BDDF5D
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Oct 2008 05:03:11 +1100 (EST)
Message-Id: <44593583-8B1D-4F99-85BA-D9A2E0EFF330@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40810080914n508150bcva235ec85322ff5cf@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 0/3] MPC5121 add pci support
Date: Wed, 8 Oct 2008 13:02:15 -0500
References: <1223406020-12278-1-git-send-email-jrigby@freescale.com>
	<77D97C6B-7F07-45AA-98D0-EE4723E2ABAD@kernel.crashing.org>
	<fa686aa40810080914n508150bcva235ec85322ff5cf@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 8, 2008, at 11:14 AM, Grant Likely wrote:

> On Wed, Oct 8, 2008 at 12:20 AM, Kumar Gala  
> <galak@kernel.crashing.org> wrote:
>>
>> On Oct 7, 2008, at 2:00 PM, John Rigby wrote:
>>
>>> The following three patches add pci support for MPC5121
>>> These got no NACKs back in August but they were not picked up
>>> by anyone either.
>>
>> I'll look at picking up patches 1/3 and 3/3.  I'll leave 2/3 to  
>> Grant.
>
> Kumar, since both 1/3 and 2/3 touch fsl_pci.c, can you please pick up
> 2/3?  It won't conflict with anything that I'm pushing.  I'll post my
> ack-by line.

will do.

- k
