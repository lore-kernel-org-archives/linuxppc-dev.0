Return-Path: <bzolnier@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id DBA73DDEBE
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 05:36:42 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so750368ugf
	for <linuxppc-dev@ozlabs.org>; Wed, 04 Apr 2007 12:36:41 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH pata-2.6] sl82c105: add speedproc() method and MWDMA0/1
	support
Date: Wed, 4 Apr 2007 21:38:24 +0200
References: <200702140043.25244.sshtylyov@ru.mvista.com>
	<200702231913.55522.sshtylyov@ru.mvista.com>
	<200703290024.32035.sshtylyov@ru.mvista.com>
In-Reply-To: <200703290024.32035.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704042138.25049.bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wednesday 28 March 2007, Sergei Shtylyov wrote:
> Add the speedproc() method for setting transfer modes, modify config_for_dma()
> to call it and use ide_max_dma_mode() to select the best DMA mode.
> Add support for the multiword DMA modes 0 and 1, using the upper half of the
> 'drive_data' field to store the DMA timings to program into the drive control
> register when DMA is turned on for real.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
