Return-Path: <rostedt@home.goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id F1D50B6EF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Mar 2011 02:32:37 +1100 (EST)
Received: from hrndva-omtalb.mail.rr.com ([10.128.143.54])
	by hrndva-qmta04.mail.rr.com with ESMTP
	id <20110309152736245.MDUU1970@hrndva-qmta04.mail.rr.com>
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2011 15:27:36 +0000
Date: Wed, 9 Mar 2011 10:26:29 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [BUG] rebuild_sched_domains considered dangerous
Message-ID: <20110309152628.GA10907@home.goodmis.org>
References: <1299639487.22236.256.camel@pasglop>
	<1299665998.2308.2753.camel@twins>
	<1299670429.2308.2834.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1299670429.2308.2834.camel@twins>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jesse Larrew <jlarrew@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 09, 2011 at 12:33:49PM +0100, Peter Zijlstra wrote:
> 
> That is of course aside from the fact that we have a real bug there that
> needs fixing, but really guys, WTF!

They just wanted to give you a very nice reproducer for that bug ;)

-- Steve
