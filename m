Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199]) by ozlabs.org (Postfix) with ESMTP id 41325B7067
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Nov 2009 05:53:45 +1100 (EST)
Received: by ywh37 with SMTP id 37so3556294ywh.17
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 10:53:43 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1258108877-25435-1-git-send-email-l.fu@pengutronix.de>
References: <1257844329-20687-1-git-send-email-l.fu@pengutronix.de>
	<1258108877-25435-1-git-send-email-l.fu@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 13 Nov 2009 11:53:23 -0700
Message-ID: <fa686aa40911131053xec0774ey33e451b6233ff6c4@mail.gmail.com>
Subject: Re: [V2] Patches for mpc52xx_spi
To: Luotao Fu <l.fu@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 13, 2009 at 3:41 AM, Luotao Fu <l.fu@pengutronix.de> wrote:
>
> Hi Grand,
>
> here are the V2 of my patchset for mpc52xx_spi. Besides Wolframs suggestions I
> also added some more fixes. Details of changes can be checked in the patch
> header. Please do consider to apply the patches. The patch 1/2 e.g. fix bugs,
> which prevent the driver to work in some cases, as seen on my board.

Applied to my 'test' branch on git.secretlab.ca

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
