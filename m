Return-Path: <kyle@phobos.cabal.ca>
Received: from phobos.cabal.ca (206-248-169-182.dsl.ncf.ca [206.248.169.182])
	by ozlabs.org (Postfix) with ESMTP id B8BF9DE0C3
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 04:18:49 +1000 (EST)
Date: Tue, 9 Sep 2008 14:08:40 -0400
From: Kyle McMartin <kyle@mcmartin.ca>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH] Correct printk %pF to work on all architectures
Message-ID: <20080909180840.GA1940@phobos.i.cabal.ca>
References: <1220481754.3254.42.camel@localhost.localdomain>
	<alpine.LFD.1.10.0809031546310.3515@nehalem.linux-foundation.org>
	<1220482853.3254.47.camel@localhost.localdomain>
	<alpine.LFD.1.10.0809031602270.3515@nehalem.linux-foundation.org>
	<1220484812.3254.59.camel@localhost.localdomain>
	<alpine.LFD.1.10.0809031636320.3515@nehalem.linux-foundation.org>
	<1220492616.3254.64.camel@localhost.localdomain>
	<1220567811.4879.85.camel@pasglop>
	<57C9024A16AD2D4C97DC78E552063EA30A0DC383@orsmsx505.amr.corp.intel.com>
	<1220969561.3334.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1220969561.3334.7.camel@localhost.localdomain>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "Luck,
	Tony" <tony.luck@intel.com>,
	"linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
	Parisc List <linux-parisc@vger.kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 09, 2008 at 09:12:41AM -0500, James Bottomley wrote:
> OK, so could we get this in to -rc5 please?  It's a bug fix for parisc
> since we're currently printing rubbish.
> 

While I suppose it's a "parisc" patch, I'm not going to try to push it
unless either Linus just applies it, or we get an ack from the ppc/ia64
folks too.

... That said, please apply it, Linus. :)

Acked-by: Kyle McMartin <kyle@mcmartin.ca>

regards, Kyle
