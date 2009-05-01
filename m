Return-Path: <johnsoga@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.168])
	by ozlabs.org (Postfix) with ESMTP id EB4D4DDD1B
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 01:03:42 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so1682208wfg.15
	for <linuxppc-dev@ozlabs.org>; Fri, 01 May 2009 08:03:41 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 1 May 2009 10:03:41 -0500
Message-ID: <bb6204720905010803u1f9a3bc3g121d044c279b79e9@mail.gmail.com>
Subject: mmap dma address
From: Gabriel Johnson <johnsoga@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Could someone tell me how to mmap a dma buffer allocated with
dma_alloc_coherent?  I have found some patches that Takashi Iwai
submitted to create a dma_mmap_coherent function but it doesn't look
like its been accepted upstream, is there a reason why?  Is there a
better way for mmaping a dma address?  I am trying to get mmaping
working on a mpc5121e i2s audio driver so that I can do alsa audio
mixing.

Thanks,
Gabe
