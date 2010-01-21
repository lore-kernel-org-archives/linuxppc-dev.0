Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f204.google.com (mail-iw0-f204.google.com
	[209.85.223.204]) by ozlabs.org (Postfix) with ESMTP id 7E970B7CFD
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jan 2010 04:48:17 +1100 (EST)
Received: by iwn42 with SMTP id 42so211266iwn.9
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jan 2010 09:48:16 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1263932653-3634-12-git-send-email-agust@denx.de>
References: <1263932653-3634-1-git-send-email-agust@denx.de>
	<1263932653-3634-12-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 21 Jan 2010 10:47:56 -0700
Message-ID: <fa686aa41001210947k7f623df1m215b7db680f2c5c5@mail.gmail.com>
Subject: Re: [PATCH 11/11] powerpc/mpc5121: Add default config for MPC5121ADS
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 19, 2010 at 1:24 PM, Anatolij Gustschin <agust@denx.de> wrote:
> From: Wolfgang Denk <wd@denx.de>
>
> As more MPC512x based boards will be coming soon, a new directory
> arch/powerpc/configs/512x/ for board specific config files is created,
> following the example of other processor families.
>
> In a first step, we just copy (and update) the existing defconfig
> file for the mpc5121ads board. When new boards get added, the old
> arch/powerpc/configs/mpc5121_defconfig file will get adjusted to
> allow for a generic kernel image for MPC512x based boards.
>
> Signed-off-by: Wolfgang Denk <wd@denx.de>
> Signed-off-by: Detlev Zundel <dzu@denx.de>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
> This default config is provided only for easier testing.
>
> =A0arch/powerpc/configs/512x/mpc5121ads_defconfig | 1662 ++++++++++++++++=
++++++++

I'm not a fan off adding one-per-board defconfigs to mainline.  To
start, please just name this arch/powerpc/configs/512x_defconfig

g.
