Return-Path: <cel@us.ibm.com>
Subject: Re: [Cbe-oss-dev] [RFC, PATCH 2/4] Add support to OProfile for
	profiling Cell BE SPUs -- update
From: Carl Love <cel@us.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200701300508.56467.arnd@arndb.de>
References: <45BE4ED0.5030808@us.ibm.com> <45BE4F55.8070801@us.ibm.com>
	<200701300508.56467.arnd@arndb.de>
Content-Type: text/plain
Date: Tue, 30 Jan 2007 15:51:05 -0800
Message-Id: <1170201065.5235.43.camel@dyn9047021078.beaverton.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd:

Well most of the patch is simply cleaning up the
pm_rtas_activate_signals() routine.  I would be think
"pm_rtas_activat_signals routine cleanup" would be good.

                   Carl Love


On Tue, 2007-01-30 at 05:08 +0100, Arnd Bergmann wrote:
> On Monday 29 January 2007 20:47, Maynard Johnson wrote:
> >   The code was setting up the debug bus for group 21 when profiling on the 
> > event PPU CYCLES.  The debug bus is not actually used by the hardware 
> > performance counters when counting PPU CYCLES.  Setting up the debug bus
> > for PPU CYCLES causes signal routing conflicts on the debug bus when 
> > profiling PPU cycles and another PPU event.  This patch fixes the code to 
> > only setup the debug bus to route the performance signals for the non
> > PPU CYCLE events.
> > 
> > Signed-off-by: Maynard Johnson <mpjohn@us.ibm.com>
> > Signed-off-by: Carl Love <carll@us.ibm.com>
> 
> Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
> 
> Any suggestion for a one-line patch title?
> _______________________________________________
> cbe-oss-dev mailing list
> cbe-oss-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/cbe-oss-dev
