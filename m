Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199]) by ozlabs.org (Postfix) with ESMTP id 7E81CB7B63
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2009 08:09:45 +1100 (EST)
Received: by ywh37 with SMTP id 37so1494802ywh.17
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 13:09:44 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4AFACC6A.304@mocean-labs.com>
References: <4AFACC6A.304@mocean-labs.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 11 Nov 2009 14:09:23 -0700
Message-ID: <fa686aa40911111309k4492688xe6aed848bb3ad05c@mail.gmail.com>
Subject: Re: [PATCH 2/4] xilinx_spi: Switch to iomem functions and support
	little endian.
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

On Wed, Nov 11, 2009 at 7:38 AM, Richard R=F6jfors
<richard.rojfors@mocean-labs.com> wrote:
> This patch changes the out_(be)(8|16|32) and in_(be)(8|16|32) calls to io=
write(8|16|32)
> and ioread(8|16|32). This to be able to build on platforms not supporting=
 the in/out calls
> for instance x86.

As discussed previously, I'd rather see as an ops table instead of as
if/else in each accessor, but I won't push it unless I hear the same
opinion from others.  John what do you think?  (But if it should be an
ops table, then I want it done now so that we don't end up with
another just as invasive patch to change the form yet again in 6
months time).

Otherwise looks good to me on brief read-through.

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
