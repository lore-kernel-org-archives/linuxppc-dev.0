Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 18F5AB6F75
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Jun 2011 06:11:53 +1000 (EST)
Date: Wed, 22 Jun 2011 22:11:43 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH] fsl-diu-fb: remove the ioctl interface
Message-ID: <20110622221143.503add74@wker>
In-Reply-To: <4E012586.7050808@freescale.com>
References: <1308691655-3416-1-git-send-email-timur@freescale.com>
	<20110622003853.1041385c@wker> <4E012586.7050808@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"lethal@linux-sh.org" <lethal@linux-sh.org>,
	sun york-R58495 <R58495@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 21 Jun 2011 23:13:11 +0000
Tabi Timur-B04825 <B04825@freescale.com> wrote:

> Anatolij Gustschin wrote:
> > No! We are using ioctl interface of this driver in many video
> > rendering applications on overlay planes on huge number of boards.
> > So, please don't remove it.
> 
> Ok, I had no idea anyone was using it.
> 
> Can you email me details about how you use the ioctl interface?  If I can't 
> remove it, maybe I can clean it up.

Following DIU specific ioctls are used:

MFB_SET_CHROMA_KEY
MFB_SET_PIXFMT
MFB_GET_PIXFMT
MFB_SET_AOID
MFB_GET_AOID
MFB_GET_ALPHA
MFB_SET_ALPHA

Other ioctls can be removed. I'm not sure if someone
uses FBIOGET_GWINFO. If there are no objections from
other people, it can also be dropped.
