Return-Path: <error27@gmail.com>
Received: from mail-ww0-f52.google.com (mail-ww0-f52.google.com [74.125.82.52])
	by ozlabs.org (Postfix) with ESMTP id 53A1DB6EEE
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Aug 2010 05:18:40 +1000 (EST)
Received: by wwb22 with SMTP id 22so2352687wwb.21
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jul 2010 12:18:37 -0700 (PDT)
Date: Sat, 31 Jul 2010 21:17:43 +0200
From: Dan Carpenter <error27@gmail.com>
To: Kulikov Vasiliy <segooon@gmail.com>
Subject: Re: [PATCH 2/7] usb: fsl_udc_core: check return value of
	create_proc_read_entry()
Message-ID: <20100731191743.GF26313@bicker>
References: <1280597900-8405-1-git-send-email-segooon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1280597900-8405-1-git-send-email-segooon@gmail.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org,
	Anton Vorontsov <avorontsov@ru.mvista.com>,
	Dinh Nguyen <Dinh.Nguyen@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jul 31, 2010 at 09:38:20PM +0400, Kulikov Vasiliy wrote:
> create_proc_read_entry() may fail, if so return -ENOMEM.
> 

It can fail, but also we return NULL if procfs is disabled.  I haven't
looked at it very carefully, would this patch break the module if procfs
was disabled?

The same applies to the similar patches in this set.

regards,
dan carpenter
