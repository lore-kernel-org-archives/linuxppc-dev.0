Return-Path: <penberg@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.207])
	by ozlabs.org (Postfix) with ESMTP id D956767A46
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Feb 2005 19:24:32 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 68so372357wra
	for <linuxppc-dev@ozlabs.org>; Fri, 04 Feb 2005 00:24:29 -0800 (PST)
Message-ID: <84144f0205020400172d89eddf@mail.gmail.com>
Date: Fri, 4 Feb 2005 10:17:48 +0200
From: Pekka Enberg <penberg@gmail.com>
To: Olof Johansson <olof@austin.ibm.com>
In-Reply-To: <20050204072254.GA17565@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <20050204072254.GA17565@austin.ibm.com>
Cc: akpm@osdl.org, trini@kernel.crashing.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, penberg@cs.helsinki.fi,
	paulus@samba.org, hpa@zytor.com, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] PPC/PPC64: Introduce CPU_HAS_FEATURE() macro
Reply-To: Pekka Enberg <penberg@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Fri, 4 Feb 2005 01:22:54 -0600, Olof Johansson <olof@austin.ibm.com> wrote:
> +#define CPU_HAS_FEATURE(x)     (cur_cpu_spec->cpu_features & CPU_FTR_##x)
> +

Please drop the CPU_FTR_##x macro magic as it makes grepping more
complicated. If the enum names are too long, just do s/CPU_FTR_/CPU_/g
or something similar. Also, could you please make this a static inline
function?

                                  Pekka
