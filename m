Return-Path: <michael@ellerman.id.au>
Received: from [10.61.2.158] (ibmaus65.lnk.telstra.net [165.228.126.9])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPSA id 6261D2C0080
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2012 19:00:48 +1000 (EST)
Message-ID: <1344589252.27290.19.camel@concordia>
Subject: Re: [-next] ERROR: "epapr_hypercall_start"
 [drivers/tty/ehv_bytechan.ko] undefined!
From: Michael Ellerman <michael@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org
Date: Fri, 10 Aug 2012 19:00:52 +1000
In-Reply-To: <1344589138.27290.18.camel@concordia>
References: <CAMuHMdV9dgjdHuz3avU1dubyekcZwT70x=5W+CL7iHQuoC1n_w@mail.gmail.com>
 <1344589138.27290.18.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-08-10 at 18:58 +1000, Michael Ellerman wrote:
> On Fri, 2012-08-10 at 09:43 +0200, Geert Uytterhoeven wrote:
> > Sicne a few days, powerpc allmodconfig fails with:
> > 
> > ERROR: "epapr_hypercall_start" [drivers/tty/ehv_bytechan.ko] undefined!
> > make[2]: *** [__modpost] Error 1
> > make[1]: *** [modules] Error 2
> > 
> > http://kisskb.ellerman.id.au/kisskb/buildresult/6883300/
> 
> 
> Yep, modular build is broken.
> 
> Since this commit by the looks of it:
> 
> commit 6d2d82627f4f1e96a33664ace494fa363e0495cb
> Author: Liu Yu-B13201 <Yu.Liu@freescale.com>
> Date:   Tue Jul 3 05:48:56 2012 +0000
> 
>     PPC: Don't use hardcoded opcode for ePAPR hcall invocation
>     
>     Signed-off-by: Liu Yu <yu.liu@freescale.com>

And this address bounces, nice.

cheers
