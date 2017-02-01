Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDFLc5gVrzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 07:37:44 +1100 (AEDT)
Message-ID: <1485981445.4850.8.camel@kernel.crashing.org>
Subject: Re: [RFC] implement QUEUED spinlocks on powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eric Dumazet <eric.dumazet@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Kevin Hao <haokexin@gmail.com>, Torsten
 Duwe <duwe@suse.de>, Eric Dumazet <edumazet@google.com>, Pan Xinhui
 <xinhui.pan@linux.vnet.ibm.com>
Date: Thu, 02 Feb 2017 07:37:25 +1100
In-Reply-To: <1485968734.6360.154.camel@edumazet-glaptop3.roam.corp.google.com>
References: <1485968734.6360.154.camel@edumazet-glaptop3.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-02-01 at 09:05 -0800, Eric Dumazet wrote:
> Hi all
> 
> Is anybody working on adding QUEUED spinlocks to powerpc 64bit ?
> 
> I've seen past attempts with ticket spinlocks
> ( https://patchwork.ozlabs.org/patch/449381/ and other related links
> )
> 
> But it looks ticket spinlocks are a thing of the past.

Yes, we have a tentative implementation of qspinlock and pv variants:

https://patchwork.ozlabs.org/patch/703139/
https://patchwork.ozlabs.org/patch/703140/
https://patchwork.ozlabs.org/patch/703141/
https://patchwork.ozlabs.org/patch/703142/
https://patchwork.ozlabs.org/patch/703143/
https://patchwork.ozlabs.org/patch/703144/

Michael, what's the status with getting that merged ?

Cheers,
Ben.
