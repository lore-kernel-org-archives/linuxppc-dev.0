Return-Path: <rusty@rustcorp.com.au>
Subject: Re: [PATCH 3/3] stop_machine() now uses hard_irq_disable
From: Rusty Russell <rusty@rustcorp.com.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20070510052624.06AD7DDF2E@ozlabs.org>
References: <20070510052624.06AD7DDF2E@ozlabs.org>
Content-Type: text/plain
Date: Thu, 10 May 2007 15:33:54 +1000
Message-Id: <1178775234.7286.189.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-05-10 at 15:25 +1000, Benjamin Herrenschmidt wrote:
> Add a call to hard_irq_disable() to stop_machine so that we make sure
> IRQs are really disabled and not only lazy-disabled on archs like
> powerpc as some users of stop_machine() may rely on that.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Rusty Russell <rusty@rustcorp.com.au>

Thanks,
Rusty.
