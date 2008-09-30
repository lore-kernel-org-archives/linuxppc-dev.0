Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [PATCH] sputrace : use
	marker_synchronize_unregister()
Date: Tue, 30 Sep 2008 21:22:34 +1000
References: <48E08B05.7030802@cn.fujitsu.com>
	<200809301028.21485.jk@ozlabs.org> <20080930095520.GB7557@elte.hu>
In-Reply-To: <20080930095520.GB7557@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809302122.36117.jk@ozlabs.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	Lai Jiangshan <laijs@cn.fujitsu.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
	Ingo Molnar <mingo@elte.hu>,
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

Ingo,

> that wont work very well as the patch relies on the new
> marker_synchronize_unregister() facility.

d'oh, right you are. Should I leave this in your hands to merge?

Cheers,


Jeremy
