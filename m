Return-Path: <michael@ellerman.id.au>
Date: Wed, 22 May 2013 14:39:25 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Dennis Schridde <devurandom@gmx.net>
Subject: Re: [PATCH] powerpc/cell: Only iterate over online nodes in
 cbe_init_pm_irq()
Message-ID: <20130522043925.GC18345@concordia>
References: <1366719291-29414-1-git-send-email-michael@ellerman.id.au>
 <5021824.e1KI2ptoeP@ernie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5021824.e1KI2ptoeP@ernie>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 17, 2013 at 05:45:05PM +0200, Dennis Schridde wrote:
> Hello!
> 
> Just wanted to remind you: The patchto fix cbe_init_pm_irq() that Michael and 
> Grant sent me is still not included in Linux 3.8.12.

I didn't push that one to stable because it just fixes a warning. If you
want it you'll have to grab it yourself.

cheers
