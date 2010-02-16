Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f195.google.com (mail-yw0-f195.google.com
	[209.85.211.195]) by ozlabs.org (Postfix) with ESMTP id 0EA59B7D5E
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Feb 2010 06:52:17 +1100 (EST)
Received: by ywh33 with SMTP id 33so5717246ywh.15
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2010 11:52:16 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1266348777-30665-1-git-send-email-agust@denx.de>
References: <fa686aa41002161011r29f5323clcbb1d89a9df6614@mail.gmail.com>
	<1266348777-30665-1-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 16 Feb 2010 12:51:56 -0700
Message-ID: <fa686aa41002161151v7f25bcfeje02ba5472bbcfadd@mail.gmail.com>
Subject: Re: [PATCH] powerpc: mpc5121: correct DIU compatible property
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, dzu@denx.de, kosmo@semihalf.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 16, 2010 at 12:32 PM, Anatolij Gustschin <agust@denx.de> wrote:
> The DIU driver should bind against "fsl,mpc5121-diu"
> directly. Add this compatible property to the match
> table and fix DTS and platform code accordingly.
>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
> =A0arch/powerpc/boot/dts/mpc5121ads.dts =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A0arch/powerpc/platforms/512x/mpc512x_shared.c | =A0 =A02 +-
> =A0drivers/video/fsl-diu-fb.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A05 +++++

Merged, but only the dts and fsl-diu-fb.c hunks.  I haven't merged the
mpc512x_shared.c changes because I haven't merged your diu patches yet
(as discussed in a previous email).

g.
