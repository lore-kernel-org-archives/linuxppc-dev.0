Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0F06CB6F62
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2012 16:57:09 +1000 (EST)
Message-ID: <1334732224.1159.4.camel@pasglop>
Subject: Re: [PATCH 4/4] powerpc: Remove CONFIG_POWER4_ONLY
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
Date: Wed, 18 Apr 2012 16:57:04 +1000
In-Reply-To: <20120418165116.4bdcbbfe@kryten>
References: <20120418144254.3286ce94@kryten>
 <20120418144629.3f02e897@kryten> <1334731564.1159.2.camel@pasglop>
 <20120418165116.4bdcbbfe@kryten>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-04-18 at 16:51 +1000, Anton Blanchard wrote:
> 
> arch/powerpc/kernel/sysfs.c: if
> (cpu_has_feature(CPU_FTR_PPCAS_ARCH_V2))
> 
> I'm ok either way, should I respin to use CPU_FTR_NO_EXECUTE?

Yeah, that sysfs bit will be true if -either- of the two bits is true,
which is yet another different logic, better avoid it I think.

Cheers,
Ben.
