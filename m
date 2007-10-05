Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id A0EDEDDE1D
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Oct 2007 13:08:08 +1000 (EST)
Date: Thu, 4 Oct 2007 20:08:11 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [RFC] [PATCH] PowerPC: add more than 4MB kernel image size
	support to bootwarapper
Message-ID: <20071005030811.GA19134@mag.az.mvista.com>
References: <20070924113627.GA30504@ru.mvista.com>
	<20070925022935.GI30338@localhost.localdomain>
	<46FD0E4D.30305@ru.mvista.com>
	<20071003055005.GD18978@localhost.localdomain>
	<20071005015849.GA9862@mag.az.mvista.com>
	<20071005022554.GE25637@localhost.localdomain>
	<20071005025930.GA24218@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071005025930.GA24218@mag.az.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 04, 2007 at 07:59:30PM -0700, Mark A. Greer wrote:
> On Fri, Oct 05, 2007 at 12:25:54PM +1000, David Gibson wrote:

> > The zImage is already hardware and
> > firmware specific;
> 
> And [potentially] firmware version and zImage size specific.

I meant to add, "which is why it'll be difficult to come up with a
heuristic that will work in all situations."

Mark
