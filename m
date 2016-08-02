Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3LyT6dYVzDqdt
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 13:18:57 +1000 (AEST)
Message-ID: <1470107916.12584.8.camel@kernel.crashing.org>
Subject: Re: MPC5200 does not boot
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michal Sojka <sojkam1@fel.cvut.cz>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 02 Aug 2016 13:18:36 +1000
In-Reply-To: <20160802131643.0bb9a777@roar.ozlabs.ibm.com>
References: <874m74w1m7.fsf@steelpick.2x.cz>
 <1470105873.12584.7.camel@kernel.crashing.org>
 <20160802131643.0bb9a777@roar.ozlabs.ibm.com>
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

On Tue, 2016-08-02 at 13:16 +1000, Nicholas Piggin wrote:
> 
> Shouldn't these be PTRRELOC(spec)->cpu_features ? You are relocating
> access to the pointer word, but not the address it contains.
> identify_cpu() returns the relocated pointer which is what 32-bit
> used
> to use.

Ah indeed ! Let me check this in qemu and I'll get back to you.

Cheers,
Ben.
