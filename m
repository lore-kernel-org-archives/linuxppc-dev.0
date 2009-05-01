Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D1438DDEEF
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 08:05:08 +1000 (EST)
Message-Id: <62CA484E-F6D6-47BF-8792-58AC2B38FBC9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <ed82fe3e0905011315j4678d0c4idecc8c66d288367f@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 2/6 v2] powerpc/qe: update risc allocation for QE
Date: Fri, 1 May 2009 17:03:00 -0500
References: <1241206851-27749-1-git-send-email-Haiying.Wang@freescale.com>
	<ed82fe3e0905011315j4678d0c4idecc8c66d288367f@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Haiying Wang <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 1, 2009, at 3:15 PM, Timur Tabi wrote:

> On Fri, May 1, 2009 at 2:40 PM, Haiying Wang <Haiying.Wang@freescale.com 
> > wrote:
>> Change the RISC allocation to macros instead of enum, add function  
>> to read the
>> number of risc engines from the new property "fsl,qe-num-riscs"  
>> under qe node
>> in dts. Add new property "fsl,qe-num-riscs" description in qe.txt
>>
>> Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
>
> Acked-by: Timur Tabi <timur@freescale.com>

Applied to next

- k
