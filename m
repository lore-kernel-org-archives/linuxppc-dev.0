Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B10051007DA
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 May 2011 22:41:48 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] RapidIO: Fix default routing initialization
Date: Thu, 12 May 2011 05:37:35 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E55201C8E515@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <20110511130024.955f1981.akpm@linux-foundation.org>
References: <1305125163-14590-1-git-send-email-alexandre.bounine@idt.com>
	<20110511130024.955f1981.akpm@linux-foundation.org>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Andrew Morton" <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Moll <thomas.moll@sysgo.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrew Morton <akpm@linux-foundation.org> wrote:
=20
> The changelog doesn't permit me to determine the importance of this
> fix,
> so I don't know whether to schedule it for 2.6.39 or for -stable.

Sorry, my fault. This patch is applicable to kernel versions starting
from 2.6.37.
