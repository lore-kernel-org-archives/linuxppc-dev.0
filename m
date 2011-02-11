Return-Path: <ppc.addon@gmail.com>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5142FB70EC
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Feb 2011 11:47:37 +1100 (EST)
Received: by gyg8 with SMTP id 8so923290gyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Feb 2011 16:47:33 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 11 Feb 2011 01:47:33 +0100
Message-ID: <AANLkTik0cjEp82RH1vFEe1ewy6=dh2OM1H-=-cEy=ycn@mail.gmail.com>
Subject: linux-2.6.37 compile error for Efika (MPC5200B)
From: nello martuscielli <ppc.addon@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hi,

i've this error trying to compile my linux-2.6.37 for Genesi Efika
(MPC5200B) with sound enabled.


[...]
 LD      sound/pci/built-in.o
  LD      sound/pcmcia/pdaudiocf/built-in.o
  LD      sound/pcmcia/vx/built-in.o
  LD      sound/pcmcia/built-in.o
  LD      sound/ppc/built-in.o
  LD      sound/sh/built-in.o
  LD      sound/soc/built-in.o
  CC [M]  sound/soc/soc-core.o
sound/soc/soc-core.c: In function 'snd_soc_instantiate_card':
sound/soc/soc-core.c:1626:5: warning: passing argument 1 of
'soc_unregister_ac97_dai_link' from incompatible pointer type
sound/soc/soc-core.c:1545:13: note: expected 'struct snd_soc_codec *'
but argument is of type 'struct snd_soc_pcm_runtime *'
  CC [M]  sound/soc/soc-dapm.o
  CC [M]  sound/soc/soc-jack.o
  CC [M]  sound/soc/soc-cache.o
  CC [M]  sound/soc/soc-utils.o
  LD [M]  sound/soc/snd-soc-core.o
  LD      sound/soc/atmel/built-in.o
  LD      sound/soc/au1x/built-in.o
  LD      sound/soc/blackfin/built-in.o
  LD      sound/soc/codecs/built-in.o
  CC [M]  sound/soc/codecs/stac9766.o
  LD [M]  sound/soc/codecs/snd-soc-stac9766.o
  LD      sound/soc/davinci/built-in.o
  LD      sound/soc/ep93xx/built-in.o
  LD      sound/soc/fsl/built-in.o
  CC [M]  sound/soc/fsl/mpc5200_dma.o
sound/soc/fsl/mpc5200_dma.c:372:16: warning: 'struct of_device'
declared inside parameter list
sound/soc/fsl/mpc5200_dma.c:372:16: warning: its scope is only this
definition or declaration, which is probably not what you want
sound/soc/fsl/mpc5200_dma.c: In function 'mpc5200_hpcd_probe':
sound/soc/fsl/mpc5200_dma.c:383:31: error: dereferencing pointer to
incomplete type
sound/soc/fsl/mpc5200_dma.c:384:31: error: dereferencing pointer to
incomplete type
sound/soc/fsl/mpc5200_dma.c:385:14: error: dereferencing pointer to
incomplete type
sound/soc/fsl/mpc5200_dma.c:390:14: error: dereferencing pointer to
incomplete type
sound/soc/fsl/mpc5200_dma.c:402:27: error: dereferencing pointer to
incomplete type
sound/soc/fsl/mpc5200_dma.c:414:20: error: dereferencing pointer to
incomplete type
sound/soc/fsl/mpc5200_dma.c:428:14: error: dereferencing pointer to
incomplete type
sound/soc/fsl/mpc5200_dma.c:475:21: error: dereferencing pointer to
incomplete type
sound/soc/fsl/mpc5200_dma.c:478:38: error: dereferencing pointer to
incomplete type
sound/soc/fsl/mpc5200_dma.c: At top level:
sound/soc/fsl/mpc5200_dma.c:490:39: warning: 'struct of_device'
declared inside parameter list
sound/soc/fsl/mpc5200_dma.c: In function 'mpc5200_hpcd_remove':
sound/soc/fsl/mpc5200_dma.c:492:47: error: dereferencing pointer to
incomplete type
sound/soc/fsl/mpc5200_dma.c:494:2: error: dereferencing pointer to
incomplete type
sound/soc/fsl/mpc5200_dma.c:496:33: error: dereferencing pointer to
incomplete type
sound/soc/fsl/mpc5200_dma.c:508:21: error: dereferencing pointer to
incomplete type
sound/soc/fsl/mpc5200_dma.c: At top level:
sound/soc/fsl/mpc5200_dma.c:522:2: error: unknown field 'owner'
specified in initializer
sound/soc/fsl/mpc5200_dma.c:522:2: warning: initialization from
incompatible pointer type
sound/soc/fsl/mpc5200_dma.c:523:2: error: unknown field 'name'
specified in initializer
sound/soc/fsl/mpc5200_dma.c:523:2: warning: initialization from
incompatible pointer type
sound/soc/fsl/mpc5200_dma.c:524:2: error: unknown field 'match_table'
specified in initializer
sound/soc/fsl/mpc5200_dma.c:524:2: warning: initialization from
incompatible pointer type
sound/soc/fsl/mpc5200_dma.c:525:2: warning: initialization from
incompatible pointer type
sound/soc/fsl/mpc5200_dma.c:526:2: warning: initialization from
incompatible pointer type
make[3]: *** [sound/soc/fsl/mpc5200_dma.o] Error 1
make[2]: *** [sound/soc/fsl] Error 2
make[1]: *** [sound/soc] Error 2
make: *** [sound] Error 2
