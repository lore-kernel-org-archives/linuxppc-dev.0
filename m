Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id EE1E9B6EF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 00:05:27 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2 01/10] RapidIO: Fix RapidIO sysfs hierarchy
Date: Wed, 15 Sep 2010 07:04:41 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E5520130318F@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <20100914150429.6256b311.akpm@linux-foundation.org>
References: <1284476363-1677-1-git-send-email-alexandre.bounine@idt.com><1284476363-1677-2-git-send-email-alexandre.bounine@idt.com>
	<20100914150429.6256b311.akpm@linux-foundation.org>
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
> Non-backward compatible change?  What is the risk of breaking existing
> setups with this change?

I think that risk is very low. Assuming that this change brings sysfs
entries
to their intended hierarchy, it has sense to do it now (at relatively
early stage).
