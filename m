Return-Path: <michael@ellerman.id.au>
Date: Tue, 23 Jul 2013 23:30:32 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] module: ppc64 module CRC relocation fix causes perf issues
Message-ID: <20130723133032.GB31944@concordia>
References: <20130718140045.6794ecd5@kryten>
 <1374274770.5357.33@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1374274770.5357.33@snotra>
Cc: Neil Horman <nhorman@tuxdriver.com>, Rusty Russell <rusty@rustcorp.com.au>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 19, 2013 at 05:59:30PM -0500, Scott Wood wrote:
> On 07/17/2013 11:00:45 PM, Anton Blanchard wrote:
> >
> >Hi Scott,
> >
> >> What specifically should I do to test it?
> >
> >Could you double check perf annotate works? I'm 99% sure it will but
> >that is what was failing on ppc64.
> 
> I'm not really sure what it's supposed to look like when "perf
> annotate" works.  It spits a bunch of unreadable[1]
> dark-blue-on-black assembly code at me, all with "0.00 :" in the
> left column.
> 
> Oh, wait -- some lines have "100.00 : " on the left, in
> even-more-unreadable dark-red-on-black.
> 
> Apart from the annoying colors, is there anything specific I should
> be looking for?  Some sort of error message, or output that actually
> makes sense?

The colours look fine on my terminal, so I don't know what you've done
there. If you care you can use "--stdio" to use the plainer interface,
though it still uses colours.

That output looks fine in terms of the bug Anton was chasing. As far as
only ever hitting one instruction that does look weird.

cheers
