Return-Path: <cody@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D14402C009F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Feb 2014 10:14:20 +1100 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Wed, 5 Feb 2014 16:14:17 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 7AAA81FF0043
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Feb 2014 16:14:14 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s15NDtKh39583838
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Feb 2014 00:13:55 +0100
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s15NHXUB012313
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Feb 2014 16:17:34 -0700
Message-ID: <52F2C5BE.5080803@linux.vnet.ibm.com>
Date: Wed, 05 Feb 2014 15:14:06 -0800
From: Cody P Schafer <cody@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 4/8] powerpc: add hv_gpci interface header
References: <20140201055807.267F12C00BA@ozlabs.org>
In-Reply-To: <20140201055807.267F12C00BA@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>> diff --git a/arch/powerpc/include/asm/hv_gpci.h b/arch/powerpc/include/asm/hv_gpci.h
>
> Any reason this can't just live in arch/powerpc/perf ?
>

Nope, it should be able to keep the header there for now. As this 
interface allows determination of the HW topology, we may have some code 
that exposes that (in sysfs) at some point, which doesn't really belong 
in arch/powerpc/perf (though we could just put it there anyhow).
