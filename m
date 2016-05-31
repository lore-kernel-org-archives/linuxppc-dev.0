Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJq3Y43SpzDqdC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 20:09:45 +1000 (AEST)
Date: Tue, 31 May 2016 20:09:21 +1000
From: Anton Blanchard <anton@samba.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, acsawdey@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] powerpc: Avoid load hit store in __giveup_fpu() and
 __giveup_altivec()
Message-ID: <20160531200921.53a44e15@kryten>
In-Reply-To: <20160530081552.GA2547@visitor2.iram.es>
References: <1464523432-12605-1-git-send-email-anton@ozlabs.org>
 <20160530081552.GA2547@visitor2.iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> Huh? Make it an unsigned long please, which is the type of the msr
> field in struct pt_regs to work on both 32 and 64 bit processors.

Thanks, not sure what I was thinking there. Will respin.

Anton
