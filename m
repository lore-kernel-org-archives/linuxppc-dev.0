Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2AC9B2C013D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 16:57:50 +1000 (EST)
Message-ID: <1372921062.4122.94.camel@pasglop>
Subject: Re: [PATCH 2/2] KVM: PPC: Book3E: Add LRAT error exception handler
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
Date: Thu, 04 Jul 2013 16:57:42 +1000
In-Reply-To: <300B73AA675FCE4A93EB4FC1D42459FF0A2A4A86@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1372870566-11299-1-git-send-email-mihai.caraman@freescale.com>
 <1372870566-11299-2-git-send-email-mihai.caraman@freescale.com>
 <1372882590.8183.149@snotra>
 <300B73AA675FCE4A93EB4FC1D42459FF0A2A4A86@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-07-04 at 06:47 +0000, Caraman Mihai Claudiu-B02008 wrote:
> This is a solid reason. Ben it's ok for you to apply the combined
> patch? If so I will respin it.

Sure, but nowadays, all that stuff goes via Scott and Alex.

Cheers,
Ben.
