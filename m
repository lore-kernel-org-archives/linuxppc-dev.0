Return-Path: <paulus@ozlabs.org>
Date: Wed, 12 May 2010 11:00:03 +1000
From: Paul Mackerras <paulus@samba.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 2/2] powerpc,kexec: Speedup kexec hpte tear down
Message-ID: <20100512010003.GB3548@drongo>
References: <20100511062826.E1C49D3340@localhost.localdomain>
	<1273561463.9209.138.camel@concordia>
	<30983.1273620594@neuling.org> <1273624565.5738.8.camel@concordia>
	<7247.1273624988@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7247.1273624988@neuling.org>
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 12, 2010 at 10:43:08AM +1000, Michael Neuling wrote:

> We probably only do the remove on < 1% of the hptes now.  So I doubt we
> would get a speedup since most of the time we aren't do the remove
> anymore.

It would be nice to have some actual numbers.  Could you add some
counters and print the results at the end?  (Or don't you have any
way to print things at that stage?)

Paul.
