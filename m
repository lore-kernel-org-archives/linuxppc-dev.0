Return-Path: <timur.tabi@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EC7B11007D3
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Dec 2010 03:48:36 +1100 (EST)
Received: by iwn6 with SMTP id 6so4484551iwn.15
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Dec 2010 08:48:33 -0800 (PST)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <1279893639-24333-6-git-send-email-agust@denx.de>
References: <1279893639-24333-1-git-send-email-agust@denx.de>
	<1279893639-24333-6-git-send-email-agust@denx.de>
From: Timur Tabi <timur@freescale.com>
Date: Thu, 16 Dec 2010 10:47:53 -0600
Message-ID: <AANLkTin-TL5_TKnyHYtZdixosfqpkPNoarSTC+K4tTUb@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] fsl-diu-fb: Support setting display mode using EDID
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-fbdev@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 23, 2010 at 9:00 AM, Anatolij Gustschin <agust@denx.de> wrote:
> Adds support for encoding display mode information
> in the device tree using verbatim EDID block.
>
> If the EDID entry in the DIU node is present, the
> driver will build mode database using EDID data
> and allow setting the display modes from this database.
> Otherwise display mode will be set using mode
> entries from driver's internal database as usual.
>
> This patch also updates device tree bindings.
>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Acked-by: Timur Tabi <timur@freescale.com>
> Cc: devicetree-discuss@lists.ozlabs.org

Anatolij,

I know this patch is old, but I'm now getting back to working on the
DIU driver.  One question I have: why are you reading the EDID data
from the device tree?  Why not just read it directly from the device
using I2C?  Who is supposed to put the EDID data into the device tree
in the first place?

-- 
Timur Tabi
Linux kernel developer at Freescale
