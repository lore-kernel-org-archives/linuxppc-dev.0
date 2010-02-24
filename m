Return-Path: <mmlnx@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D76AEB7B98
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2010 09:14:58 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1OMC1H4009493
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2010 15:12:01 -0700
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1OMEcKh021144
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2010 15:14:46 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o1OMGsbP026022
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2010 15:16:55 -0700
Message-ID: <4B85A48F.6090607@us.ibm.com>
Date: Wed, 24 Feb 2010 14:13:35 -0800
From: Mike Mason <mmlnx@us.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] eeh: Fixing a bug when pci structure is null
References: <1264789719-15591-1-git-send-email-leitao@linux.vnet.ibm.com>
	<4B6864F4.1030106@linux.vnet.ibm.com>	<20100202180503.GL4757@pengutronix.de>
	<4B699CB9.3030605@linux.vnet.ibm.com>	<4B7EBF9A.7020801@linux.vnet.ibm.com>
	<1266616485.23523.1026.camel@pasglop>
In-Reply-To: <1266616485.23523.1026.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Linas Vepstas <linasvepstas@gmail.com>,
	Breno Leitao <leitao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2/19/2010 1:54 PM, Benjamin Herrenschmidt wrote:
> On Fri, 2010-02-19 at 14:43 -0200, Breno Leitao wrote:
>> Hi Ben,
>>
>> I'd like to ask about this patch ? Should I re-submit ?
>>
>> Thanks,
>>
>> Breno Leitao wrote:
>>> During a EEH recover, the pci_dev structure can be null, mainly if an
>>> eeh event is detected during cpi config operation. In this case, the
>>> pci_dev will not be known (and will be null) the kernel will crash
>>> with the following message:
>
> It should be in -next, can you dbl check ?

I just confirmed the patch is in the -next tree.

Mike

>
> Cheers,
> Ben.
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
