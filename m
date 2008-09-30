Return-Path: <mingo@elte.hu>
Date: Tue, 30 Sep 2008 13:30:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [Cbe-oss-dev] [PATCH] sputrace : use
	marker_synchronize_unregister()
Message-ID: <20080930113020.GE21367@elte.hu>
References: <48E08B05.7030802@cn.fujitsu.com>
	<200809301028.21485.jk@ozlabs.org> <20080930095520.GB7557@elte.hu>
	<200809302122.36117.jk@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200809302122.36117.jk@ozlabs.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	Lai Jiangshan <laijs@cn.fujitsu.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	cbe-oss-dev@ozlabs.org, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Jeremy Kerr <jk@ozlabs.org> wrote:

> Ingo,
> 
> > that wont work very well as the patch relies on the new
> > marker_synchronize_unregister() facility.
> 
> d'oh, right you are. Should I leave this in your hands to merge?

would be nice if you could give your Acked-by for the sputrace bits, 
then we can merge it. It's a oneliner so it shouldnt cause merging 
trouble in linux-next.

	Ingo
