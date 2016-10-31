Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t6qNS1Sj8zDvKB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 20:50:16 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, imunsie@au1.ibm.com,
 fbarrat@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl: Fix error handling
In-Reply-To: <e6e4eb09-28d1-ad7c-6ab3-8e954c27ed23@au1.ibm.com>
References: <20161030213451.24624-1-christophe.jaillet@wanadoo.fr>
 <e6e4eb09-28d1-ad7c-6ab3-8e954c27ed23@au1.ibm.com>
Date: Mon, 31 Oct 2016 20:50:12 +1100
Message-ID: <87vaw826gb.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:

> On 31/10/16 08:34, Christophe JAILLET wrote:
>> 'cxl_dev_context_init()' returns an error pointer in case of error, not
>> NULL. So test it with IS_ERR.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>
>> ---
>> un-compiled because I don't have the required  cross build environment.
>
> Builds fine here.
>
> In future, you might want to bundle all 3 of your patches either into 1 
> patch (while they are changes which can be done separately, it's all 
> fixes to one type of problem in relation to one function, so personally 
> I'm okay with that) or send it as a series, so that it's clear to 
> everyone that they're all related fixes.

> Additionally, having the same patch subject line for two patches sent in 
> short succession is a bit confusing - in future, try and avoid that.

Yeah. I actually assumed it was two versions of the same patch.

cheers
