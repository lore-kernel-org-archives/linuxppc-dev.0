Return-Path: <glikely@secretlab.ca>
Received: from mail-iy0-f170.google.com (mail-iy0-f170.google.com
	[209.85.210.170]) by ozlabs.org (Postfix) with ESMTP id F207F1007D7
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Dec 2010 03:54:17 +1100 (EST)
Received: by iym14 with SMTP id 14so2154474iym.15
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Dec 2010 08:54:16 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <AANLkTin-TL5_TKnyHYtZdixosfqpkPNoarSTC+K4tTUb@mail.gmail.com>
References: <1279893639-24333-1-git-send-email-agust@denx.de>
	<1279893639-24333-6-git-send-email-agust@denx.de>
	<AANLkTin-TL5_TKnyHYtZdixosfqpkPNoarSTC+K4tTUb@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 16 Dec 2010 09:53:55 -0700
Message-ID: <AANLkTi=NwY_gcBXeKXeGX-qist3tMQ4EWqj3twYGfeWD@mail.gmail.com>
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

On Thu, Dec 16, 2010 at 9:47 AM, Timur Tabi <timur@freescale.com> wrote:
> On Fri, Jul 23, 2010 at 9:00 AM, Anatolij Gustschin <agust@denx.de> wrote=
:
>> Adds support for encoding display mode information
>> in the device tree using verbatim EDID block.
>>
>> If the EDID entry in the DIU node is present, the
>> driver will build mode database using EDID data
>> and allow setting the display modes from this database.
>> Otherwise display mode will be set using mode
>> entries from driver's internal database as usual.
>>
>> This patch also updates device tree bindings.
>>
>> Signed-off-by: Anatolij Gustschin <agust@denx.de>
>> Acked-by: Timur Tabi <timur@freescale.com>
>> Cc: devicetree-discuss@lists.ozlabs.org
>
> Anatolij,
>
> I know this patch is old, but I'm now getting back to working on the
> DIU driver. =A0One question I have: why are you reading the EDID data
> from the device tree? =A0Why not just read it directly from the device
> using I2C? =A0Who is supposed to put the EDID data into the device tree
> in the first place?

This is for devices which don't have an i2c edid channel.

g.
