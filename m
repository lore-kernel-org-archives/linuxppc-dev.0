Return-Path: <SRS0+eb7ae25f47855baec100+914+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [205.233.218.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6F287679FF
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2006 04:22:04 +1100 (EST)
Subject: Re: yaboot 1.3.14 release candidate 1
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Nasrat <pnasrat@redhat.com>
In-Reply-To: <1139538538.3638.14.camel@enki.eridu>
References: <1139538538.3638.14.camel@enki.eridu>
Content-Type: text/plain
Date: Thu, 23 Feb 2006 17:21:56 +0000
Message-Id: <1140715316.22730.21.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-02-09 at 21:28 -0500, Paul Nasrat wrote:
> Amiga partition support (Sven Luther),

Does this still have an off-by-one bug in the partition numbering which
coincidentally matches a similar bug in the Pegasos OpenFirmware? If so,
we should fix it before any proper release.

-- 
dwmw2
