Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8FA6C67C2C
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 04:20:16 +1000 (EST)
In-Reply-To: <20061003130245.58267c54.kim.phillips@freescale.com>
References: <20061002200946.1f411bcc.kim.phillips@freescale.com>
	<41AC40EF-31AC-42FE-9C1A-9B80233D2E64@kernel.crashing.org>
	<20061003130245.58267c54.kim.phillips@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <86FE84DE-D709-4CFF-A910-09971F7D82B8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/7] Add MPC8360EMDS board support
Date: Tue, 3 Oct 2006 13:20:35 -0500
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 3, 2006, at 1:02 PM, Kim Phillips wrote:

> On Mon, 2 Oct 2006 22:19:14 -0500
> Kumar Gala <galak@kernel.crashing.org> wrote:
>
>> [snip]
>>
>
>>> +static u8 *bcsr_regs = NULL;
>>> +
>>> +u8 *get_bcsr(void)
>>> +{
>>> +	return bcsr_regs;
>>> +}
>>
>> Is get_bcsr() needed since you removed its use from ucc_geth?  (if
>> not, let's remove it and the header as well).
>>
>
> it will be once we figure out a better way of handling it from usb  
> and ethernet phy code. I had just removed it due to Paul's comment  
> (bcsr bits are being manipulated in the wrong place (ucc_geth)).

ok, but nothing is using it in the tree anymore.

Clearly, the phy support for ucc_geth needs to move over to using the  
phylib and I think Andy was looking at how to provide board level  
hooks to the phylib.

- k
