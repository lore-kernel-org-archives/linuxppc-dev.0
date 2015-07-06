Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 06DF91A0452
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2015 15:05:14 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Mon, 6 Jul 2015 10:35:08 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id E78C93940057
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2015 10:35:01 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6654rq54587888
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Jul 2015 10:35:01 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t663qwrw022508
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Jul 2015 09:22:58 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH slof] README: Update with patch submittion note
In-Reply-To: <1436155750-16815-1-git-send-email-aik@ozlabs.ru>
References: <1436155750-16815-1-git-send-email-aik@ozlabs.ru>
Date: Mon, 06 Jul 2015 10:33:35 +0530
Message-ID: <87r3olri6w.fsf@linux.vnet.ibm.com>
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

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> This adds a maillist and emails to be used when posting a patch for SLOF.
>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>
> I was asked to describe somewhere how to post new patches so this is the first
> attempt. Please fix my english and add/remove personal emails and any other
> comments are also welcome. Thanks!
>
> ---
>  README | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/README b/README
> index 58e9294..b81fd08 100644
> --- a/README
> +++ b/README
> @@ -11,6 +11,7 @@ Index
>  2.2 Overview of the source code
>  2.4 Extending the Forth engine
>  3.0 Limitations
> +4.0 Submitting patches
>
>
>  1.0 Introduction to Slimline Open Firmware
> @@ -236,6 +237,15 @@ To add primitives:
>   On a JS21 all memory configurations should work.
>
>
> +4.0 Submitting patches
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> +
> +Patches for SLOF should be made against https://github.com/aik/SLOF,
> +the master branch and posted to linuxppc-dev@ozlabs.org.

> It is recommended also cc: to

It is recommended to cc:

> + aik@ozlabs.ru, nikunj@linux.vnet.ibm.com,
> + thuth@redhat.com.
> +
> +
>  Documentation
>  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>
> -- 
> 2.4.0.rc3.8.gfb3e7d5
