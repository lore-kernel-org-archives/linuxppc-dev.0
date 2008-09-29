Return-Path: <SRS0+eca42ad5687460bcf41d+1863+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 29 Sep 2008 11:13:19 -0400
From: Christoph Hellwig <hch@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: Re: [PATCH] sputrace : use marker_synchronize_unregister()
Message-ID: <20080929151319.GA25247@infradead.org>
References: <48E08B05.7030802@cn.fujitsu.com> <20080929082722.GB18663@elte.hu>
	<20080929151147.GH11245@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080929151147.GH11245@Krystal>
Cc: Lai Jiangshan <laijs@cn.fujitsu.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
	Jeremy Kerr <jk@ozlabs.org>, Ingo Molnar <mingo@elte.hu>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 29, 2008 at 11:11:47AM -0400, Mathieu Desnoyers wrote:
> We need a marker_synchronize_unregister() before the end of exit() to make sure
> every probe callers have exited the non preemptible section and thus are not
> executing the probe code anymore.

Looks good.
