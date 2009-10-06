Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EDA5BB7BCF
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Oct 2009 17:45:56 +1100 (EST)
Subject: Re: [PATCH 3/6] 8xx: get rid of _PAGE_HWWRITE dependency in MMU.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <OFC7D289B7.88EECA01-ONC1257647.001E8F29-C1257647.002265AF@transmode.se>
References: <1254744999-3158-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254744999-3158-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254744999-3158-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254744999-3158-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254773824.7122.33.camel@pasglop>
	<OF3182684B.BB80DBCF-ONC1257646.0073D59B-C1257646.0075AB6F@transmode.se>
	<1254778643.7122.43.camel@pasglop>
	<OF16069D5F.03682AAC-ONC1257646.00774BB8-C1257646.0078E24B@transmode.se>
	<1254780556.7122.47.camel@pasglop>
	<OF346FF2E6.3CCDA0FA-ONC1257646.007C13A0-C1257646.007DF396@transmode.se>
	<1254784539.7122.52.camel@pasglop>
	<OFB8E4035A.83748CF0-ONC1257646.0080A097-C1257646.00819DD6@transmode.se>
	<1254789255.7122.95.camel@pasglop>
	<OFC7D289B7.88EECA01-ONC1257647.001E8F29-C1257647.002265AF@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 06 Oct 2009 17:45:47 +1100
Message-Id: <1254811547.6035.3.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-10-06 at 08:15 +0200, Joakim Tjernlund wrote:

> Yes, I would too but TLB Miss knows nothing about load/store, protection etc.
> because DSISR isn't set. So I cannot see any other way than the TLB Error way.

Hrm... that MMU really sucks more than I thought :-(

I'll go read the manual and think about that a bit more.

> But I guess BookE knows if it is a load or store in TLB Miss?
> Then it can emulate changed bit I guess.

Yes, it knows.

Cheers,
Ben.
