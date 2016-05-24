Return-Path: <vipin@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rDlQ30W4xzDqJ1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 05:11:38 +1000 (AEST)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vipin@linux.vnet.ibm.com>;
 Wed, 25 May 2016 05:11:37 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0699E3578056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 05:11:35 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4OJBQ9n64880676
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 05:11:34 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4OJB2qS012639
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 05:11:02 +1000
Subject: Re: [PATCH 0215/1529] Fix typo
References: <20160521120413.11129-1-andrea.gelmini@gelma.net>
Cc: Andrea Gelmini <andrea.gelmini@gelma.net>,
 Stewart Smith <stewart@linux.vnet.ibm.com>
To: Linux ppc dev <linuxppc-dev@lists.ozlabs.org>
From: Vipin K Parashar <vipin@linux.vnet.ibm.com>
Message-ID: <5744A734.2040505@linux.vnet.ibm.com>
Date: Wed, 25 May 2016 00:40:44 +0530
MIME-Version: 1.0
In-Reply-To: <20160521120413.11129-1-andrea.gelmini@gelma.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Saturday 21 May 2016 05:34 PM, Andrea Gelmini wrote:
> Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>

Reviewed-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>

> ---
>   arch/powerpc/include/asm/opal-api.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
> index 9bb8ddf..70b5cbc 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -802,7 +802,7 @@ struct opal_sg_entry {
>   };
>
>   /*
> - * Candiate image SG list.
> + * Candidate image SG list.
>    *
>    * length = VER | length
>    */
> @@ -852,7 +852,7 @@ struct opal_i2c_request {
>    * with individual elements being 16 bits wide to fetch the system
>    * wide EPOW status. Each element in the buffer will contain the
>    * EPOW status in it's bit representation for a particular EPOW sub
> - * class as defiend here. So multiple detailed EPOW status bits
> + * class as defined here. So multiple detailed EPOW status bits
>    * specific for any sub class can be represented in a single buffer
>    * element as it's bit representation.
>    */
