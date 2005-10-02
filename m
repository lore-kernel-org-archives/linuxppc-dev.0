Return-Path: <adaplas@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.202])
	by ozlabs.org (Postfix) with ESMTP id 80600683E7
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Oct 2005 17:15:54 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id l1so129568nzf
	for <linuxppc-dev@ozlabs.org>; Sun, 02 Oct 2005 00:15:53 -0700 (PDT)
Message-ID: <433F8774.6000301@gmail.com>
Date: Sun, 02 Oct 2005 15:08:36 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1128225462.8267.24.camel@gaston> <1128232186.8267.31.camel@gaston>
In-Reply-To: <1128232186.8267.31.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linux-fbdev-devel@lists.sourceforge.net,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvidiafb: PPC & mode setting fixes (#2)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> (This version removes a useless bit that slipped in the previous one)
> 
> This patch fixes a couple of things in nvidiafb:
> 
>  - The code for retreiving the mode from Open Firmware was broken. It
> would crash at boot and was copied from the old rivafb code that didn't
> work very well (I'll update rivafb too one of these days).

What do you think of making EDID retrieval from the OF generic?  Or is
it too much hassle?

> 
>  - The mode setting code produced weird results on the 5200 card in the
> iMac G5 here. X "nv" code works fine though. After comparing them, I
> found out that we aren't really manipulating some VGA bits the same way
> and X code seemed better, so I slightly changed the mode setting to do
> the same and that fixed the problem. (The display was strangely shifted
> with garbage in the margin but not on all lines, and not in bpp 32)
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Thanks for the fix :-)  

Acked-by: Antonino Daplas <adaplas@pol.net>
