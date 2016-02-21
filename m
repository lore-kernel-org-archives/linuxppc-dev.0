Return-Path: <manoj@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0A6921A0C5E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 09:49:56 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <manoj@linux.vnet.ibm.com>;
 Sun, 21 Feb 2016 15:49:54 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 5B9683E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Feb 2016 15:49:52 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1LMnqct33292520
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Feb 2016 15:49:52 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1LMnpNs023028
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Feb 2016 15:49:52 -0700
Reply-To: manoj@linux.vnet.ibm.com
Subject: Re: Fwd: [PATCH v4 09/18] cxl: New possible return value from hcall
References: <1455658751-16970-10-git-send-email-fbarrat@linux.vnet.ibm.com>
 <56CA2CBD.4070907@linux.vnet.ibm.com>
To: fbarrat@linux.vnet.ibm.com
Cc: Ian Munsie <imunsie@au1.ibm.com>, michael.neuling@au1.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
From: Manoj Kumar <manoj@linux.vnet.ibm.com>
Message-ID: <56CA3F22.2000804@linux.vnet.ibm.com>
Date: Sun, 21 Feb 2016 16:50:10 -0600
MIME-Version: 1.0
In-Reply-To: <56CA2CBD.4070907@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reviewed-by: Manoj Kumar <manoj@linux.vnet.ibm.com>

---
Manoj Kumar


> Subject: [PATCH v4 09/18] cxl: New possible return value from hcall
> Date: Tue, 16 Feb 2016 22:39:02 +0100
> From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> To: imunsie@au1.ibm.com, michael.neuling@au1.ibm.com,
> mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
>
> From: Christophe Lombard <clombard@linux.vnet.ibm.com>
>
> The hcalls introduced for CAPI use a possible new value:
> H_STATE (invalid state).

Same suggestion as earlier. Try to avoid references to
the term CAPI externally.
