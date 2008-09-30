Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: Re: [PATCH] sputrace : use marker_synchronize_unregister()
Date: Tue, 30 Sep 2008 10:28:19 +1000
References: <48E08B05.7030802@cn.fujitsu.com> <20080929082722.GB18663@elte.hu>
	<20080929151147.GH11245@Krystal>
In-Reply-To: <20080929151147.GH11245@Krystal>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809301028.21485.jk@ozlabs.org>
Cc: Lai Jiangshan <laijs@cn.fujitsu.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, cbe-oss-dev@ozlabs.org,
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

Mathieu,

> We need a marker_synchronize_unregister() before the end of exit() to
> make sure every probe callers have exited the non preemptible section
> and thus are not executing the probe code anymore.

Looks good - added to spufs.git.

Cheers,


Jeremy
