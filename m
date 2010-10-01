Return-Path: <dedekind1@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by ozlabs.org (Postfix) with ESMTP id 01747B70F8
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Oct 2010 05:29:13 +1000 (EST)
Received: by bwz13 with SMTP id 13so2672956bwz.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 01 Oct 2010 12:29:10 -0700 (PDT)
Subject: Re: [PATCH 15/18] mtd: Fix endianness issues from device tree
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Ian Munsie <imunsie@au1.ibm.com>
In-Reply-To: <1285916771-18033-16-git-send-email-imunsie@au1.ibm.com>
References: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
	<1285916771-18033-16-git-send-email-imunsie@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 01 Oct 2010 22:29:06 +0300
Message-ID: <1285961346.32172.10.camel@brekeke>
Mime-Version: 1.0
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Artem Bityutskiy <Artem.Bityutskiy@nokia.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	paulus@samba.org, linux-mtd@lists.infradead.org,
	Sean MacLennan <smaclennan@pikatech.com>,
	Tejun Heo <tj@kernel.org>, Julia Lawall <julia@diku.dk>,
	Steve Deiters <SteveDeiters@basler.com>,
	Anatolij Gustschin <agust@denx.de>, David Woodhouse <dwmw2@infradead.org>,
	"David S. Miller" <davem@davemloft.net>
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-10-01 at 17:06 +1000, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> This patch adds the appropriate conversions to correct the endianness
> issues in the MTD driver whenever it accesses the device tree (which is
> always big endian).
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>

Pushed to l2-mtd-2.6.git, thanks!

-- 
Best Regards,
Artem Bityutskiy (Битюцкий Артём)
