Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 1EC44B6F84
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Jun 2011 08:39:04 +1000 (EST)
Date: Wed, 22 Jun 2011 00:38:53 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] fsl-diu-fb: remove the ioctl interface
Message-ID: <20110622003853.1041385c@wker>
In-Reply-To: <1308691655-3416-1-git-send-email-timur@freescale.com>
References: <1308691655-3416-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-fbdev@vger.kernel.org, lethal@linux-sh.org,
	yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 21 Jun 2011 16:27:35 -0500
Timur Tabi <timur@freescale.com> wrote:

> The ioctl interface in the Freescale DIU framebuffer driver is just a
> collection of miscellaneous functions which were only used in a one-time
> demo application that was never distributed.  Plus, the ioctls were spread
> across two types (both conflicting), and the demo app didn't even use all
> of them.
> 
> Removing the ioctl interface also allows us to clean up the header file and
> remove other unusued stuff.

No! We are using ioctl interface of this driver in many video
rendering applications on overlay planes on huge number of boards.
So, please don't remove it.

Anatolij
