Return-Path: <trini@kernel.crashing.org>
Date: Thu, 11 Aug 2005 13:18:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050811201821.GY3187@smtp.west.cox.net>
References: <20050811195927.GX3187@smtp.west.cox.net>
	<BF36E655-9534-4FCD-9EB3-A1CD36C7981D@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BF36E655-9534-4FCD-9EB3-A1CD36C7981D@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Gill Becky-BGILL <becky.bruce@freescale.com>,
	linuxppc64-dev@ozlabs.org
Subject: Re: RFC: proposed arch/powerpc directory structure
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 11, 2005 at 03:13:30PM -0500, Kumar Gala wrote:
> 
> On Aug 11, 2005, at 2:59 PM, Tom Rini wrote:
> 
> >On Wed, Aug 10, 2005 at 11:45:10AM -0500, Becky Bruce wrote:
> >
> >[snip]
[snip]
> >>        83xx/ (may collapse into classic 32 at some point)
> >>        86xx/ (may collapse into classic 32 at some point)
> >>        pq2/ (may collapse into classic 32 at some point)
> >>
> >
> >PQ2 is the marketing name for 82xx, lets just call it 82xx.
> 
> The problem is that PQ2 describes a subset of 82xx (it nots  
> 8240/8241/8245).

All the more reason imho to stick all 82xx stuff under '82xx', rather
than classic32 or 'pq2'.

> >I don't like the idea of sticking subdirs in classic32/ either, but  
> >also
> >can't think of a better name for the catchall of 7xx and 74xx boards.
> 
> I dont think we where planning on subdirs in classic32.

I took "may collapse into classic 32 at some point" to mean "move into
classic32/ at some point", for some reason.  collapsing the content into
classic32/ will bring us back to the bad-old-days of everything in
platforms/ (or kernel/).

-- 
Tom Rini
http://gate.crashing.org/~trini/
