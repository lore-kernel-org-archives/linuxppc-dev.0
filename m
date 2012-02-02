Return-Path: <acrux_it@libero.it>
Received: from outrelay08.libero.it (outrelay08.libero.it [212.52.84.112])
 by ozlabs.org (Postfix) with ESMTP id 97C09104792
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2012 03:57:06 +1100 (EST)
Date: Thu, 2 Feb 2012 17:57:51 +0100
From: acrux <acrux_it@libero.it>
To: acrux <acrux_it@libero.it>
Subject: Re: Efika (mpc5200b): sound doesn't build/work from linux-2.6.38.x
Message-Id: <20120202175751.2c6e4bb9.acrux_it@libero.it>
In-Reply-To: <20120202034803.2fb7690b.acrux_it@libero.it>
References: <20120202034803.2fb7690b.acrux_it@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, Jon Smirl <jonsmirl@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2 Feb 2012 03:48:03 +0100
acrux <acrux_it@libero.it> wrote:

> board: Genesi Efika (MPC5200B)
> problem: unable to use sound subsystem instead it works fine with linux-2.6.36.4 (+ device tree supplement, attached) .
> 
> With linux-2.6.38.8 and linux-2.6.39.4 it doesn't build.
> That's from my build log:
> 
> [...]
>   LD      sound/soc/blackfin/built-in.o
>   LD      sound/soc/codecs/built-in.o
>   CC [M]  sound/soc/codecs/stac9766.o
>   LD [M]  sound/soc/codecs/snd-soc-stac9766.o
>   LD      sound/soc/davinci/built-in.o
>   LD      sound/soc/ep93xx/built-in.o
>   LD      sound/soc/fsl/built-in.o
>   CC [M]  sound/soc/fsl/mpc5200_dma.o
> sound/soc/fsl/mpc5200_dma.c:372:16: warning: 'struct of_device' declared inside parameter list
> sound/soc/fsl/mpc5200_dma.c:372:16: warning: its scope is only this definition or declaration, which is probably not what you want
> sound/soc/fsl/mpc5200_dma.c: In function 'mpc5200_hpcd_probe':
> sound/soc/fsl/mpc5200_dma.c:383:31: error: dereferencing pointer to incomplete type
> sound/soc/fsl/mpc5200_dma.c:384:31: error: dereferencing pointer to incomplete type
> sound/soc/fsl/mpc5200_dma.c:385:14: error: dereferencing pointer to incomplete type
> sound/soc/fsl/mpc5200_dma.c:390:14: error: dereferencing pointer to incomplete type
> sound/soc/fsl/mpc5200_dma.c:402:27: error: dereferencing pointer to incomplete type
> sound/soc/fsl/mpc5200_dma.c:414:20: error: dereferencing pointer to incomplete type
> sound/soc/fsl/mpc5200_dma.c:428:14: error: dereferencing pointer to incomplete type
> sound/soc/fsl/mpc5200_dma.c:475:21: error: dereferencing pointer to incomplete type
> sound/soc/fsl/mpc5200_dma.c:478:38: error: dereferencing pointer to incomplete type
> sound/soc/fsl/mpc5200_dma.c: At top level:
> sound/soc/fsl/mpc5200_dma.c:490:39: warning: 'struct of_device' declared inside parameter list
> sound/soc/fsl/mpc5200_dma.c: In function 'mpc5200_hpcd_remove':
> sound/soc/fsl/mpc5200_dma.c:492:47: error: dereferencing pointer to incomplete type
> sound/soc/fsl/mpc5200_dma.c:494:2: error: dereferencing pointer to incomplete type
> sound/soc/fsl/mpc5200_dma.c:496:33: error: dereferencing pointer to incomplete type
> sound/soc/fsl/mpc5200_dma.c:508:21: error: dereferencing pointer to incomplete type
> sound/soc/fsl/mpc5200_dma.c: At top level:
> sound/soc/fsl/mpc5200_dma.c:522:2: error: unknown field 'owner' specified in initializer
> sound/soc/fsl/mpc5200_dma.c:522:2: warning: initialization from incompatible pointer type
> sound/soc/fsl/mpc5200_dma.c:523:2: error: unknown field 'name' specified in initializer
> sound/soc/fsl/mpc5200_dma.c:523:2: warning: initialization from incompatible pointer type
> sound/soc/fsl/mpc5200_dma.c:524:2: error: unknown field 'match_table' specified in initializer
> sound/soc/fsl/mpc5200_dma.c:524:2: warning: initialization from incompatible pointer type
> sound/soc/fsl/mpc5200_dma.c:525:2: warning: initialization from incompatible pointer type
> sound/soc/fsl/mpc5200_dma.c:526:2: warning: initialization from incompatible pointer type
> make[3]: *** [sound/soc/fsl/mpc5200_dma.o] Error 1
> make[2]: *** [sound/soc/fsl] Error 2
> make[1]: *** [sound/soc] Error 2
> make: *** [sound] Error 2
> 
> 

well, i got the same error with also linux-2.6.37. Btw, this was already reported about a year ago:
http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-February/088415.html


-- 
acrux <acrux_it@libero.it>
