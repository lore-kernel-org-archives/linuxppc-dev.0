Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E0F782C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Mar 2014 20:04:54 +1100 (EST)
Message-ID: <1395651884.30488.10.camel@pasglop>
Subject: Re: [PATCH 18/18] powerpc/boot: add PPC64_BOOT_WRAPPER config option
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Cedric Le Goater <clg@fr.ibm.com>
Date: Mon, 24 Mar 2014 20:04:44 +1100
In-Reply-To: <532FEEF0.40607@fr.ibm.com>
References: <1395328213-19206-1-git-send-email-clg@fr.ibm.com>
 <1395328213-19206-19-git-send-email-clg@fr.ibm.com>
 <1395632548.3460.135.camel@pasglop> <532FEEF0.40607@fr.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-03-24 at 09:38 +0100, Cedric Le Goater wrote:
> Hi Benjamin,
> 
> > So I originally applied all 3 last patches of the series as one
> > (collapsed them in git) in order to not break bisection.
> > 
> > However, I had to take the series out in the end due to it
> > causing this error on some of my test configs:
> > 
> > powerpc64-linux-ld: cannot find arch/powerpc/boot/pseries-head.o: No such file or directory
> >
> > I haven't had a chance to investigate yet, but sadly it looks like
> > this series might have to wait for the next round.
> 
> OK. I will take a look. 

Specifically it was my cell and bimini configs, I'll get you the actual
config files (they are not defconfigs) separately.

Cheers,
Ben.
