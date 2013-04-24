Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 720402C00F8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 15:56:17 +1000 (EST)
Date: Wed, 24 Apr 2013 07:55:54 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Tiejun Chen <tiejun.chen@windriver.com>
Subject: Re: [PATCH 1/1] usb: ehci-fsl: set INCR8 mode only on MPC512x
Message-ID: <20130424075554.1ae85c65@crub>
In-Reply-To: <1366772110-9620-1-git-send-email-tiejun.chen@windriver.com>
References: <1366772110-9620-1-git-send-email-tiejun.chen@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 24 Apr 2013 10:55:10 +0800
Tiejun Chen <tiejun.chen@windriver.com> wrote:

> commit 761bbcb7, "usb: ehci-fsl: set INCR8 mode for system bus interface
> on MPC512x", introduced to fix one MPC5121e (M36P) Errata by setting
> INCR8 mode for system bus interface on MPC512x, but we should make sure
> this is only valid for MPC512x like other parts of this commit. Otherwise

NAK. It is already only valid for MPC512x.

> this would issue other platforms as abnormal without this similar Errata.

This setting is in the ehci_fsl_mpc512x_drv_resume() function which is
not called on other platforms.

Thanks,

Anatolij
