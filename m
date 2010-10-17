Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f170.google.com (mail-yx0-f170.google.com
	[209.85.213.170]) by ozlabs.org (Postfix) with ESMTP id 48D54B70ED
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Oct 2010 12:05:55 +1100 (EST)
Received: by yxn22 with SMTP id 22so1566840yxn.15
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Oct 2010 18:05:53 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1287256647.1781.34.camel@brekeke>
References: <1286878714-13090-1-git-send-email-Mingkai.hu@freescale.com>
	<1286878714-13090-2-git-send-email-Mingkai.hu@freescale.com>
	<1286878714-13090-3-git-send-email-Mingkai.hu@freescale.com>
	<1286878714-13090-4-git-send-email-Mingkai.hu@freescale.com>
	<1286878714-13090-5-git-send-email-Mingkai.hu@freescale.com>
	<1286878714-13090-6-git-send-email-Mingkai.hu@freescale.com>
	<1287256647.1781.34.camel@brekeke>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 16 Oct 2010 19:05:33 -0600
Message-ID: <AANLkTimr03KAKnz5sfwm19=KzB-ik95WM_qQO0YP9qVs@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] mtd: m25p80: add support to parse the partitions
	by OF node
To: dedekind1@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: kumar.gala@freescale.com, david-b@pacbell.net, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org, spi-devel-general@lists.sourceforge.net,
	Mingkai Hu <Mingkai.hu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Oct 16, 2010 at 1:17 PM, Artem Bityutskiy <dedekind1@gmail.com> wro=
te:
> On Tue, 2010-10-12 at 18:18 +0800, Mingkai Hu wrote:
>> Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
>> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>> ---
>> v4:
>> =A0- Updated to latest kernel base(Linux 2.6.36-rc7).
>> =A0- Made changes according to Grant's comments.
>
> Looks good to me, pushed to l2-mtd-2.6.git, thanks.

Wait!  It will break whenever CONFIG_OF is not set.  I broke
linux-next with this patch.  It can be solved by wrapping the block
with #ifdef CONFIG_OF, but I'd like to find a better solution.

g.
