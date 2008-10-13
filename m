Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D51D3DE5D0
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 04:47:07 +1100 (EST)
Message-Id: <8BA1DE5D-9815-4855-BC4C-C84809753D57@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <1223918983.16033.30.camel@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 2/3] kvmppc: add hypercall infrastructure - guest part v3
Date: Mon, 13 Oct 2008 12:44:07 -0500
References: <1221546450-15761-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1221546450-15761-3-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<F51E4B63-C0B1-4394-872E-3C8A3C0C0BB4@kernel.crashing.org>
	<1223918983.16033.30.camel@localhost.localdomain>
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 13, 2008, at 12:29 PM, Hollis Blanchard wrote:

> On Mon, 2008-10-13 at 11:42 -0500, Kumar Gala wrote:
>>> +
>>> +/* Hypercalls use the beat ABI */
>>> +#define KVM_HYPERCALL_BIN 0x44000022
>>
>> Any reason this isn't 'sc' ?
>>
>> Also, can we make this "sc 1" so its works when we have HW hypervisor
>> support?
>
> Actually, it is "sc 1".
>
> Many versions of as (including 2.16.1) don't recognize that  
> instruction.
> This is the standard workaround for situations like that.

Ahh, we'll than can we add that to the comment, and rename  
'KVM_HYPERCALL_BIN' to something like 'EPAPR_HYPERCALL_INSTR'

- k
