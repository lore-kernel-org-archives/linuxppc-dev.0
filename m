Return-Path: <arjan@linux.intel.com>
Received: from azsmga101.ch.intel.com (mga07.intel.com [143.182.124.22])
	by ozlabs.org (Postfix) with ESMTP id AA39BDE0AB
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2009 16:04:01 +1100 (EST)
Message-ID: <497FE4E7.8070303@linux.intel.com>
Date: Tue, 27 Jan 2009 20:53:59 -0800
From: Arjan van de Ven <arjan@linux.intel.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] bootgraph: fix for use with dot symbols
References: <19599.1233113450@neuling.org>
In-Reply-To: <19599.1233113450@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Neuling wrote:
> powerpc has dot symbols, so the dmesg output looks like:
>  
> <4>[    0.327310] calling  .migration_init+0x0/0x9c @ 1
> <4>[    0.327595] initcall .migration_init+0x0/0x9c returned 1 after 0 usecs
> 
> The below fixes bootgraph.pl so it handles this correctly.  


question for the ppc folks.... why does the "print symbol" magic format string
thing print a dot symbol and not the real function name?
Should that be fixed instead?
