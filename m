Return-Path: <anton@ozlabs.org>
Date: Wed, 22 Mar 2006 23:17:47 +1100
From: Anton Blanchard <anton@samba.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] possible scheduler deadlock in 2.6.16
Message-ID: <20060322121747.GE30422@krispykreme>
References: <20060322104143.GC30422@krispykreme>
	<4421307F.8020300@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4421307F.8020300@yahoo.com.au>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, mingo@elte.hu,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 
Hi Nick,

> You're right. I can't think of a better fix, although we've been trying
> to avoid adding cpu to the runqueue structure.
>
> I was going to suggest moving more work into wake_sleeping_dependent
> instead, but cores with 4 and more threads now make that less desirable
> I suppose.

My thoughts too. I wasnt sure if davem is planning to use the sibling
code for his niagara work, but locking us down to 2 siblings sounds like
a bad idea.

Anton
