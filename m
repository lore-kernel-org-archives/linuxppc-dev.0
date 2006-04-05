Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0628B67A0E
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Apr 2006 14:33:33 +1000 (EST)
In-Reply-To: <20060405130553.3240e5ea.sfr@canb.auug.org.au>
References: <Pine.LNX.4.44.0604041612320.30113-100000@gate.crashing.org>
	<20060405102837.66b44c43.sfr@canb.auug.org.au>
	<1E1C6A02-5C4D-4A3A-8483-8D5E2773680B@kernel.crashing.org>
	<20060405130553.3240e5ea.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <426751E3-A5CA-4656-B9CC-3D3F19375B32@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'for_paulus' branch of powerpc
Date: Tue, 4 Apr 2006 23:33:52 -0500
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 4, 2006, at 10:05 PM, Stephen Rothwell wrote:

> Hi Kumar,
>
> On Tue, 4 Apr 2006 20:23:23 -0500 Kumar Gala  
> <galak@kernel.crashing.org> wrote:
>>
>> We need the irq rework before I'd be willing to do this.  The main
>> dependancy between asm-ppc and asm-powerpc is the static IRQs we
>> currently have.  I'd rather spend time on fixing up the IRQ handling
>> to parse the flat dev tree.
>
> I agree entirely.  To clrify, I was referring to header files that  
> only
> exist in include/asm-ppc and are trivial to move.
>
> Patches following ...

Agreed.

- k
