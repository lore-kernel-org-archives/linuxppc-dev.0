Return-Path: <glikely@secretlab.ca>
Received: from mail-iy0-f170.google.com (mail-iy0-f170.google.com
	[209.85.210.170]) by ozlabs.org (Postfix) with ESMTP id C022C1007D7
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Dec 2010 04:42:42 +1100 (EST)
Received: by iym14 with SMTP id 14so2186342iym.15
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Dec 2010 09:42:41 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4D0A4C38.3010105@freescale.com>
References: <1279893639-24333-1-git-send-email-agust@denx.de>
	<1279893639-24333-6-git-send-email-agust@denx.de>
	<AANLkTin-TL5_TKnyHYtZdixosfqpkPNoarSTC+K4tTUb@mail.gmail.com>
	<AANLkTi=NwY_gcBXeKXeGX-qist3tMQ4EWqj3twYGfeWD@mail.gmail.com>
	<4D0A446E.5020600@freescale.com>
	<AANLkTinOf__X0p3_5G90KkYS9PXpB2j0_06MFhFcZzqO@mail.gmail.com>
	<4D0A4C38.3010105@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 16 Dec 2010 10:42:21 -0700
Message-ID: <AANLkTimVxKojtWP=X2=5SoZZu0_dHkWxmHxhXj1-jr+U@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] fsl-diu-fb: Support setting display mode using EDID
To: Timur Tabi <timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-fbdev@vger.kernel.org,
	Anatolij Gustschin <agust@denx.de>, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 16, 2010 at 10:28 AM, Timur Tabi <timur@freescale.com> wrote:
> Grant Likely wrote:
>> No. =A0It is a static property of the board/machine. =A0It is expected i=
t
>> to be encoded into the board's .dts file.
>
> Ok, but that only makes sense if the monitor is hard-wired to the board i=
tself.
> =A0If a user can attach any monitor he wants, then the EDID data can't be=
 known at
> compile time.
>
> I guess it's no different than using hard-coded memory controller program=
ming
> instead of SPD. =A0You can safely avoid SPD only if the DDR chips are sol=
dered on
> the board.

Correct, if a real EDID i2c channel exists, then an edid property
should *not* be specified in the device tree.

g.
