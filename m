Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 86C85B6FAC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2012 01:03:57 +1000 (EST)
Message-ID: <4FEB20CB.20807@freescale.com>
Date: Wed, 27 Jun 2012 10:03:39 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 4/4] powerpc/perf: Use perf_instruction_pointer in
 callchains
References: <20120626210013.2fbb9044@kryten> <20120626210420.4e5e7e78@kryten>
 <4FEA4013.5030003@freescale.com> <20120627135928.06e91f76@kryten>
In-Reply-To: <20120627135928.06e91f76@kryten>
Content-Type: text/plain; charset="UTF-8"
Cc: sukadev@linux.vnet.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/26/2012 10:59 PM, Anton Blanchard wrote:
> 
> Hi Scott,
> 
>> Won't this break core-fsl-emb, which doesn't define
>> perf_instruction_pointer()?
> 
> It links ok for me. You should get the default version:
> 
> #ifndef perf_misc_flags
> # define perf_misc_flags(regs) \
>                 (user_mode(regs) ? PERF_RECORD_MISC_USER : PERF_RECORD_MISC_KERNEL)
> # define perf_instruction_pointer(regs) instruction_pointer(regs)
> #endif

OK, sorry -- forgot to grep outside arch/powerpc. :-)

-Scott
