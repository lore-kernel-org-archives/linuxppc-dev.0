Return-Path: <bzolnier@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.155])
	by ozlabs.org (Postfix) with ESMTP id 94673DE1FA
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 07:19:50 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so1944601fgg.39
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 14:19:46 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: Re: [PATCH] scc_pata.c: do setup itself instead of
	ide_setup_pci_device ()
Date: Tue, 15 Apr 2008 22:39:17 +0200
References: <200804150314.m3F3EDv9026609@toshiba.co.jp>
In-Reply-To: <200804150314.m3F3EDv9026609@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200804152239.17249.bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 15 April 2008, Akira Iguchi wrote:
> scc_pata has the different BAR configuration and using ide_setup_pci_device()
> is inappropriate. 
> (ide_setup_pci_device() expects a normal PCI IDE controller with
> BAR0..BAR3 either non-existant or being primary/secondary port bases
> in I/O space.)
> 
> This patch do all needed setup itself instead of calling ide_setup_pci_device().
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>

Thanks for quickly handling it, applied.
