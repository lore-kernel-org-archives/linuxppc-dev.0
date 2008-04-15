Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2671BDE38C
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 00:51:38 +1000 (EST)
Message-Id: <85DC1468-5861-4434-AC4D-47280266E4E4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <EE972833-6928-4ECC-B257-432DFD947627@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 03/12] [POWERPC] Remove and replace uses of PPC_MEMSTART
	with memstart_addr
Date: Tue, 15 Apr 2008 09:51:31 -0500
References: <1207824531-27168-1-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-2-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-3-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-4-git-send-email-galak@kernel.crashing.org>
	<18436.23196.673130.542635@cargo.ozlabs.ibm.com>
	<EE972833-6928-4ECC-B257-432DFD947627@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 15, 2008, at 9:35 AM, Kumar Gala wrote:
>
> On Apr 15, 2008, at 2:34 AM, Paul Mackerras wrote:
>> Kumar Gala writes:
>>
>>> +phys_addr_t memstart_addr;
>>> +EXPORT_SYMBOL(memstart_addr);
>>
>> Do you have a modular user of memstart_addr in mind?
>
> I believe its needed for the CONFIG_RELOCATE build, but I can double  
> check that.

I've removed it from this patch and will add it back to the 85xx: add  
reloc patch if needed.

- k
