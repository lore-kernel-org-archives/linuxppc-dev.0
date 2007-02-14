Return-Path: <bzolnier@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.227])
	by ozlabs.org (Postfix) with ESMTP id D67EDDDE2D
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 06:42:34 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id i31so341659wxd
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 11:42:31 -0800 (PST)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] (pata-2.6 fix queue) sl82c105: rework PIO support
Date: Wed, 14 Feb 2007 20:48:00 +0100
References: <200702140101.26639.sshtylyov@ru.mvista.com>
In-Reply-To: <200702140101.26639.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702142048.00786.bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tuesday 13 February 2007 23:01, Sergei Shtylyov wrote:
> Get rid of the 'pio_speed' member of 'ide_drive_t' that was only used by this
> driver by storing the PIO mode timings in the 'drive_data' instead -- this
> allows us to greatly simplify the process  of "reloading" of the chip's timing
> register and do in right in the ide_dma_off_quietly() and to turn the former
> config_for_pio() into the tuneproc() method.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> This patch has also been actually tested at last. :-)

applied
