Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 86EF7B6EDD
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 00:01:06 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2 06/10] RapidIO: Modify sysfs initialization for switches
Date: Wed, 15 Sep 2010 06:38:32 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E55201303168@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <20100914151026.4d9599b4.akpm@linux-foundation.org>
References: <1284476363-1677-1-git-send-email-alexandre.bounine@idt.com><1284476363-1677-7-git-send-email-alexandre.bounine@idt.com>
	<20100914151026.4d9599b4.akpm@linux-foundation.org>
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
> This is also a non-back compatible userspace-visible change?

This should be a safe change because endpoints do not have a routing
table.
RapidIO differentiates devices by using naming templates for switches
and endpoints (":s:" and ":e:") and this indicates which device features
are available to a userspace application.  =20
