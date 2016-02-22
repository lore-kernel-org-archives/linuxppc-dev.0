Return-Path: <manoj@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9AE061A05B8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 05:53:40 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <manoj@linux.vnet.ibm.com>;
 Mon, 22 Feb 2016 11:53:38 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id BDDE219D803F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 11:41:32 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1MIrZt526411164
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 11:53:35 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1MIrYhZ016034
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 11:53:35 -0700
Reply-To: manoj@linux.vnet.ibm.com
Subject: Re: Fwd: [PATCH v4 11/18] cxl: Separate bare-metal fields in adapter
 and AFU data structures
References: <1455658751-16970-12-git-send-email-fbarrat@linux.vnet.ibm.com>
 <56CA2CD1.7020908@linux.vnet.ibm.com> <56CA60E8.6090607@linux.vnet.ibm.com>
 <56CB4BF0.2040906@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>, michael.neuling@au1.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
From: Manoj Kumar <manoj@linux.vnet.ibm.com>
Message-ID: <56CB5942.9000104@linux.vnet.ibm.com>
Date: Mon, 22 Feb 2016 12:53:54 -0600
MIME-Version: 1.0
In-Reply-To: <56CB4BF0.2040906@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2/22/2016 11:57 AM, Frederic Barrat wrote:
> Manoj,
>
> Point taken. Those constants are all defined in the architecture
> document (CAIA). We should probably use more macros there.
> However, since those were not introduced by this patch, I'll put it in
> my todo list for the future, but don't intend to address it in this
> patchset.
>
>    Fred

Fred:

I am fine with this approach.

--
Manoj Kumar
