Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 7F7C2B7063
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Nov 2009 05:30:10 +1100 (EST)
Received: by yxe8 with SMTP id 8so3496068yxe.17
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 10:30:08 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4AFD50F0.6050805@mocean-labs.com>
References: <4AFD50F0.6050805@mocean-labs.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 13 Nov 2009 11:29:46 -0700
Message-ID: <fa686aa40911131029uddb497ah7907ccd9dc23c6e3@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] xilinx_spi: Split into platform and of driver,
	support new IP, platform independence.
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

On Fri, Nov 13, 2009 at 5:28 AM, Richard R=F6jfors
<richard.rojfors@mocean-labs.com> wrote:
> Hi,
>
> To follow is a series of patches against the xilinx_spi driver.
>
> The patchset is against 2.6.32-rc6
>
> The patchset addresses several problems in the current driver:
> * It's PPC only (OF and uses PPC specific memory operations)
> * Only supporting big endian writes
> * Supports only 8bit SPI, support for DS570 (also 16 or 32 bit) is added.
> * A platform driver is introduced for non OF capable architectures.
>
> These patches were posted as one big patch up to 4 iterations, not splitt=
ed into 4.
>
> This version, 3, is updated after review from Grant Likely and John Linn
>
> John Linn has also tested the code on PPC, I have only tested on X86.

Applied to my 'test' branch on git.secretlab.ca.  There was a conflict
on patch 3/4 with a previous bugfix from John Linn.  Please check that
I've fixed it up correctly.

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
