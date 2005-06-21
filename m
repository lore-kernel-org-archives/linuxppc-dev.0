Return-Path: <trini@kernel.crashing.org>
Date: Tue, 21 Jun 2005 16:41:51 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050621234151.GB15203@smtp.west.cox.net>
References: <1117614390.19020.24.camel@gaston>
	<1117614484.19020.27.camel@gaston>
	<1117783104.31082.151.camel@gaston>
	<1117819176.6517.290.camel@cashmere.sps.mot.com>
	<1118199997.6850.106.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1118199997.6850.106.camel@gaston>
Cc: linuxppc64-dev@ozlabs.org,
	"linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Subject: Re: Discuss: Adding OF Flat Dev Tree to ppc32
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jun 08, 2005 at 01:06:37PM +1000, Benjamin Herrenschmidt wrote:
[snip]
> Regarding code in arch/ppc*, I'm not sure what the right approach would
> be. I'd say first copy things around, and we'll what we end up with.

How about we just do:
obj-y += ../../ppc64/kernel/flat_tree.o
or so like x86_64 does for a handful of things?

-- 
Tom Rini
http://gate.crashing.org/~trini/
