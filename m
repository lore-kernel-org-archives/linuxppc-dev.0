Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ss5273yFgzDqBr
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Oct 2016 12:16:47 +1100 (AEDT)
Date: Sun, 9 Oct 2016 12:16:09 +1100
From: Anton Blanchard <anton@samba.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Vaidyanathan
 Srinivasan <svaidy@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: CPU hotplug hits oops in select_idle_sibling()
Message-ID: <20161009121609.7a973b5c@kryten>
In-Reply-To: <20161008140304.GH3142@twins.programming.kicks-ass.net>
References: <20161008220733.366e8c6b@kryten>
 <20161008140304.GH3142@twins.programming.kicks-ass.net>
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

Hi Peter,

> > I updated to mainline as of today and tried CPU hotplug via the
> > ppc64_cpu tool:  
> 
> http://lkml.kernel.org/r/1475922278-3306-1-git-send-email-wanpeng.li@hotmail.com

Thanks, this fixes the issue for me.

Anton
