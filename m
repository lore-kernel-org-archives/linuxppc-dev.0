Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6A4372C00C5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 17:34:00 +1000 (EST)
Message-ID: <1374737592.6142.67.camel@pasglop>
Subject: Re: [PATCH v2] powerpc: kernel: remove useless code which related
 with 'max_cpus'
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chen Gang <gang.chen@asianux.com>
Date: Thu, 25 Jul 2013 17:33:12 +1000
In-Reply-To: <51F0C2E8.3050005@asianux.com>
References: <51ECCA10.7010709@asianux.com>
 <51ECCEA8.5040406@linux.vnet.ibm.com> <51ECD0BF.8080605@asianux.com>
 <51ECD3D4.9020405@asianux.com> <51ECD664.7040708@linux.vnet.ibm.com>
 <20130723134431.GF31944@concordia> <51EF1F97.3070409@asianux.com>
 <20130724011640.GA6042@concordia> <51EF375D.9060006@asianux.com>
 <20130725031501.GA15673@concordia> <1374729381.6142.59.camel@pasglop>
 <51F0B68F.4000402@asianux.com> <1374731505.6142.64.camel@pasglop>
 <51F0C2E8.3050005@asianux.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: chenhui.zhao@freescale.com, "paulus@samba.org" <paulus@samba.org>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-07-25 at 14:17 +0800, Chen Gang wrote:
> 
> Hmm... for an extern function (espeically have been implemented in
> various modules), normally, we can assume it may fail in some cases
> (although now, we don't know what cases can cause its failure).
> 
> If "we don't have a good way to handle the failure", "print the related
> warning message" is an executable choice (or "BUG_ON()", if it is critical).
> 
> So, if the performance is not sensible, I still suggest to let extern
> function have return value.

This is not a module function. We are not doing a uni course on how to
write C code here. Be real.

Ben.
