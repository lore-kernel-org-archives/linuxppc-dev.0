Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjTx73mYLzDwSn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 18:31:23 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id g1so9164716pgn.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 23:31:23 -0800 (PST)
Subject: Re: [PATCH v4 01/12] powerpc: Add #defs for paca->soft_enabled flags
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 mpe@ellerman.id.au
References: <1482134828-18811-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1482134828-18811-2-git-send-email-maddy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, anton@samba.org,
 npiggin@gmail.com
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <f69a3c42-b795-0c14-f812-0ff45489146f@gmail.com>
Date: Tue, 20 Dec 2016 18:31:02 +1100
MIME-Version: 1.0
In-Reply-To: <1482134828-18811-2-git-send-email-maddy@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<snip>
>
> +/*
> + * flags for paca->soft_enabled
> + */
> +#define IRQ_DISABLE_MASK_NONE	1
> +#define IRQ_DISABLE_MASK_LINUX	0
> +

Isn't one just the complement of the other?

Balbir
