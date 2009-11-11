Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199]) by ozlabs.org (Postfix) with ESMTP id B1DD5B7088
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2009 08:17:27 +1100 (EST)
Received: by ywh37 with SMTP id 37so1503135ywh.17
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 13:17:26 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4AFACCDE.7050802@mocean-labs.com>
References: <4AFACCDE.7050802@mocean-labs.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 11 Nov 2009 14:17:06 -0700
Message-ID: <fa686aa40911111317p66303b82g52246210a8e3cb5e@mail.gmail.com>
Subject: Re: [PATCH 4/4] xilinx_spi: add a platform driver using the
	xilinx_spi common module.
To: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@mocean-labs.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>, dbrownell@users.sourceforge.net,
	John Linn <John.Linn@xilinx.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 11, 2009 at 7:40 AM, Richard R=F6jfors
<richard.rojfors@mocean-labs.com> wrote:
> This patch adds in a platform device driver using the xilinx_spi common m=
odule.
>
> Signed-off-by: Richard R=F6jfors <richard.rojfors@mocean-labs.com>

Pretty straight forward stuff.  Looks right to me.  (Except of course
for adding the pdata structure earlier in the series so that the
of_driver can use it too.

Thanks for all this work.

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
