Return-Path: <sshtylyov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 376C0DDEC7
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 05:52:34 +1000 (EST)
Message-ID: <4614023F.90809@ru.mvista.com>
Date: Wed, 04 Apr 2007 23:53:35 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH pata-2.6] sl82c105: add speedproc() method and MWDMA0/1
	support
References: <200702140043.25244.sshtylyov@ru.mvista.com>
	<200702231913.55522.sshtylyov@ru.mvista.com>
	<200703290024.32035.sshtylyov@ru.mvista.com>
	<200704042138.25049.bzolnier@gmail.com>
In-Reply-To: <200704042138.25049.bzolnier@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>Add the speedproc() method for setting transfer modes, modify config_for_dma()
>>to call it and use ide_max_dma_mode() to select the best DMA mode.
>>Add support for the multiword DMA modes 0 and 1, using the upper half of the
>>'drive_data' field to store the DMA timings to program into the drive control
>>register when DMA is turned on for real.

>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> applied

    I now also have almost complete patch to merge PIO/DMA timings and so get 
rid of selectproc() there... :-)

MBR, Sergei
