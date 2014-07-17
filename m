Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 83D291A0253
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 00:25:22 +1000 (EST)
Message-ID: <53C7DCCF.60803@suse.de>
Date: Thu, 17 Jul 2014 16:25:19 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Mihai Caraman <mihai.caraman@freescale.com>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v5 0/5] Read guest last instruction from
 kvmppc_get_last_inst()
References: <1405596148-1507-1-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1405596148-1507-1-git-send-email-mihai.caraman@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 17.07.14 13:22, Mihai Caraman wrote:
> Read guest last instruction from kvmppc_get_last_inst() allowing the function
> to fail in order to emulate again. On bookehv architecture search for
> the physical address and kmap it, instead of using Load External PID (lwepx)
> instruction. This fixes an infinite loop caused by lwepx's data TLB miss
> exception handled in the host and the TODO for execute-but-not-read entries
> and TLB eviction.

Looks very good apart from minor nits. Please let me know whether you 
can send a final patch set fixing those or you would like me to fix it 
up while applying them.


Alex
