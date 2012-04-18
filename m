Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F13BFB6F62
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2012 16:46:10 +1000 (EST)
Message-ID: <1334731564.1159.2.camel@pasglop>
Subject: Re: [PATCH 4/4] powerpc: Remove CONFIG_POWER4_ONLY
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
Date: Wed, 18 Apr 2012 16:46:04 +1000
In-Reply-To: <20120418144629.3f02e897@kryten>
References: <20120418144254.3286ce94@kryten> <20120418144629.3f02e897@kryten>
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

On Wed, 2012-04-18 at 14:46 +1000, Anton Blanchard wrote:

> +       ALT_FTR_SECTION_END_NESTED_IFCLR((CPU_FTR_PPCAS_ARCH_V2), 487)

So if I remember properly, this means you key off if both
CPU_FTR_NOEXECUTE and CPU_FTR_NODISRALIGN are clear... is
there a point ? You make the patch simpler by only keying
on NO_EXECUTE which afaik is a power4 or later only feature no ?

Cheers,
Ben.
