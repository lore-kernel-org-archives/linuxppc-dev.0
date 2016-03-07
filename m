Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7A9111A011D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 16:54:58 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 7 Mar 2016 15:24:40 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 16B943578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 16:24:38 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u275OTjM58064988
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 16:24:37 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u275O5cb030226
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 16:24:05 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: "michael.neuling" <michael.neuling@au1.ibm.com>,
 manoj <manoj@linux.vnet.ibm.com>, mrochs <mrochs@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v6 14/20] cxl: Support to flash a new image on the adapter
 from a guest
In-reply-to: <1457090804-9719-15-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1457090804-9719-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1457090804-9719-15-git-send-email-fbarrat@linux.vnet.ibm.com>
Date: Mon, 07 Mar 2016 16:23:40 +1100
Message-Id: <1457328109-sup-7976@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +struct cxl_adapter_image {
> +    __u64 flags;
> +    __u64 data;
> +    __u64 len_data;
> +    __u64 len_image;
> +    __u64 reserved1;
> +    __u64 reserved2;
> +    __u64 reserved3;
> +    __u64 reserved4;
> +};

Thanks, that looks better now :)

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
