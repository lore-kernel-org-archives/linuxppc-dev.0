Return-Path: <anton@samba.org>
Date: Wed, 18 Apr 2012 16:51:16 +1000
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/4] powerpc: Remove CONFIG_POWER4_ONLY
Message-ID: <20120418165116.4bdcbbfe@kryten>
In-Reply-To: <1334731564.1159.2.camel@pasglop>
References: <20120418144254.3286ce94@kryten> <20120418144629.3f02e897@kryten>
 <1334731564.1159.2.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Ben,

> So if I remember properly, this means you key off if both
> CPU_FTR_NOEXECUTE and CPU_FTR_NODISRALIGN are clear... is
> there a point ? You make the patch simpler by only keying
> on NO_EXECUTE which afaik is a power4 or later only feature no ?

Was going to do that, but noticed ARCH_V2 was used elsewhere:

arch/powerpc/kernel/sysfs.c: if (cpu_has_feature(CPU_FTR_PPCAS_ARCH_V2))

I'm ok either way, should I respin to use CPU_FTR_NO_EXECUTE?

Anton
