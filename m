Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 42582B6EFE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2012 13:17:31 +1100 (EST)
Message-ID: <1326853009.26116.30.camel@pasglop>
Subject: Re: [RFC 13/14] irq_domain: Remove 'new' irq_domain in favour of
 the ppc one
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 18 Jan 2012 13:16:49 +1100
In-Reply-To: <CACxGe6ufk+BUoXZBKm5Q-O1Aj1j=18fJ5KjOC-fKQMbpw4z=mw@mail.gmail.com>
References: <1326313337-24603-1-git-send-email-grant.likely@secretlab.ca>
 <1326313337-24603-14-git-send-email-grant.likely@secretlab.ca>
 <4F0DFC0F.2090005@gmail.com>
 <CACxGe6vVSO0cTgPurr6jFoo9QF_W02UaABOFYadCTQGU9dcwmg@mail.gmail.com>
 <4F0F7B60.5040701@gmail.com> <4F14E05C.30207@codeaurora.org>
 <1326771731.26116.29.camel@pasglop>
 <CACxGe6ufk+BUoXZBKm5Q-O1Aj1j=18fJ5KjOC-fKQMbpw4z=mw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, Russell King <linux@arm.linux.org.uk>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robherring2@gmail.com>, Michael Bohan <mbohan@codeaurora.org>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-01-17 at 17:28 -0700, Grant Likely wrote:
> BTW: Ben, if you can carve out some time, I'd appreciate a look over
> my series and make sure you're okay with it.  Once it's had some
> testing by arm and ppc folks, I want to get it into linux-next.

I intend to do so but not while I'm at LCA :-)

Cheers,
Ben.
