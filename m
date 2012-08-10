Return-Path: <michael@ellerman.id.au>
Message-ID: <1344589138.27290.18.camel@concordia>
Subject: Re: [-next] ERROR: "epapr_hypercall_start"
 [drivers/tty/ehv_bytechan.ko] undefined!
From: Michael Ellerman <michael@ellerman.id.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 10 Aug 2012 18:58:58 +1000
In-Reply-To: <CAMuHMdV9dgjdHuz3avU1dubyekcZwT70x=5W+CL7iHQuoC1n_w@mail.gmail.com>
References: <CAMuHMdV9dgjdHuz3avU1dubyekcZwT70x=5W+CL7iHQuoC1n_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Linux-Next <linux-next@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 stuart.yoder@freescale.com, yu.liu@freescale.com,
 Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-08-10 at 09:43 +0200, Geert Uytterhoeven wrote:
> Sicne a few days, powerpc allmodconfig fails with:
> 
> ERROR: "epapr_hypercall_start" [drivers/tty/ehv_bytechan.ko] undefined!
> make[2]: *** [__modpost] Error 1
> make[1]: *** [modules] Error 2
> 
> http://kisskb.ellerman.id.au/kisskb/buildresult/6883300/


Yep, modular build is broken.

Since this commit by the looks of it:

commit 6d2d82627f4f1e96a33664ace494fa363e0495cb
Author: Liu Yu-B13201 <Yu.Liu@freescale.com>
Date:   Tue Jul 3 05:48:56 2012 +0000

    PPC: Don't use hardcoded opcode for ePAPR hcall invocation
    
    Signed-off-by: Liu Yu <yu.liu@freescale.com>
    Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
    Signed-off-by: Alexander Graf <agraf@suse.de>



cheers
