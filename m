Return-Path: <dja@axtens.net>
Received: from mail-pg0-x22f.google.com (mail-pg0-x22f.google.com
 [IPv6:2607:f8b0:400e:c05::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ybTqx2QBbzDqF4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 12:07:08 +1100 (AEDT)
Received: by mail-pg0-x22f.google.com with SMTP id s2so14037664pge.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 17:07:08 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, tlfalcon@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 stable@vger.kernel.org, "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Subject: Re: [PATCH] ibmveth: Kernel crash LSO offload flag toggle
In-Reply-To: <20171113230155.99682-1-bryantly@linux.vnet.ibm.com>
References: <20171113230155.99682-1-bryantly@linux.vnet.ibm.com>
Date: Tue, 14 Nov 2017 12:07:01 +1100
Message-ID: <87wp2t3byi.fsf@linkitivity.dja.id.au>
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

Hi Bryant,

A few things:

1) The commit message could probably be trimmed, especially the stack
traces.

2) What exactly are you changing and why does it fix the issue? I
couldn't figure that out from the commit message.

3) Does this need a Fixes: tag?


>  	}
>  
> -	netdev->min_mtu = IBMVETH_MIN_MTU;
> -	netdev->max_mtu = ETH_MAX_MTU;
> -

4) What does the above hunk do? It seems unrelated...


Regards,
Daniel
