Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D71B7B6FD7
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Jun 2011 09:36:20 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: disable timebase synchronization under
	the hypervisor
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <083792FF-81CD-407C-B6B8-6D0481A0D65D@kernel.crashing.org>
References: <1308092673-13045-1-git-send-email-timur@freescale.com>
	<20110614181406.294cdf5f@schlenkerla.am.freescale.net>
	<4DF7EB8E.8020308@freescale.com>
	<20110614182517.776d7e77@schlenkerla.am.freescale.net>
	<1308103091.2635.13.camel@pasglop>  <4DF814A3.7070209@freescale.com>
	<1308105196.2635.16.camel@pasglop>
	<083792FF-81CD-407C-B6B8-6D0481A0D65D@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 25 Jun 2011 09:36:07 +1000
Message-ID: <1308958567.32158.336.camel@pasglop>
Mime-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
	Tabi Timur-B04825 <B04825@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"paulus@samba.org" <paulus@samba.org>,
	McClintock Matthew-B29882 <B29882@freescale.com>,
	Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-06-22 at 06:44 -0500, Kumar Gala wrote:
> 
> Any ETA on Paul's intro of the FTR bit?  If not I'll pull this into my
> 'next' tree and we can clean up later.

His latest KVM patch set has that.

Cheers,
Ben.
