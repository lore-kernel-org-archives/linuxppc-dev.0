Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AED1A2C0088
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2012 15:55:21 +1000 (EST)
Message-ID: <1347342911.2603.39.camel@pasglop>
Subject: Re: [PATCH 2/6] powerpc: Add enable_ppr kernel parameter to enable
 PPR save/restore
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Haren Myneni <haren@linux.vnet.ibm.com>
Date: Tue, 11 Sep 2012 15:55:11 +1000
In-Reply-To: <504ECF35.9070305@linux.vnet.ibm.com>
References: <1347190671.3418.12.camel@hbabu-laptop>
 <1347235922.2385.138.camel@pasglop> <13010.1347236558@neuling.org>
 <504ECF35.9070305@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulus@samba.org, Michael Neuling <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-09-10 at 22:42 -0700, Haren Myneni wrote:
> 
> Thanks Michael. Yes, we noticed 6% overhead with null syscall test.
> Hence added cmdline option as suggested. I will add this comment in
> the
> changelog.
> 
> Regarding the option name, I thought about various ones such as
> retain_process_ppr, retain_smt_priority, save_ppr and etc. Finally
> added
> 'enable_ppr' since it enables CPU_FTR (CPU_FTR_HAS_PPR) which allows
> to
> save/restore PPR value. Sure, I will change this option.

No, that isn't a problem with the name. It's a problem with the polarity
of the option.

If you need a command line argument to enable the option, then nobody
will enable it, it's pointless.

Cheers,
Ben.
