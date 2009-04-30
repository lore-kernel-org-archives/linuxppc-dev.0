Return-Path: <bzolnier@gmail.com>
Received: from mail-bw0-f171.google.com (mail-bw0-f171.google.com
	[209.85.218.171]) by ozlabs.org (Postfix) with ESMTP id 13219DDF74
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 02:37:53 +1000 (EST)
Received: by bwz19 with SMTP id 19so1882002bwz.9
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 09:37:51 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] alim15x3: Remove historical hacks,
	re-enable init_hwif for PowerPC
Date: Thu, 30 Apr 2009 18:39:09 +0200
References: <c8485d470904150202s1f5c8cd7p34f0eaf4872f3e17@mail.gmail.com>
	<c8485d470904270146g7b7204eckc58cd57449a41f45@mail.gmail.com>
	<20090427184742.GA6435@oksana.dev.rtsoft.ru>
In-Reply-To: <20090427184742.GA6435@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Message-Id: <200904301839.13468.bzolnier@gmail.com>
Content-Type: Text/Plain;
  charset="utf-8"
Cc: linuxppc-dev@ozlabs.org, Roderick Colenbrander <thunderbird2k@gmail.com>,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 27 April 2009 20:47:42 Anton Vorontsov wrote:
> Some time ago we had to disable init_hwif callback for PowerPC builds.
> That was because of a historical IRQ overwrite in the driver, which
> was causing IDE malfunction on the MPC8610HPCD PowerPC boards.
> 
> It's unclear whether this overwrite is still useful, but it is proven
> to cause a bit of harm, and today some PowerPC targets (Xilinx ML510,
> as reported by Roderick Colenbrander) need the init_hwif, so we have
> to re-enable it and remove the overwrite.
> 
> Reported-by: Roderick Colenbrander <thunderbird2k@gmail.com>
> Suggested-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

thanks, I applied it to ide-2.6.git/for-next
