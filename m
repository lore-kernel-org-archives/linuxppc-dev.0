Return-Path: <michael@ellerman.id.au>
Message-ID: <1354777104.9974.5.camel@concordia>
Subject: Re: [stable] [PATCH] powerpc/ptrace: Fix build with gcc 4.6
From: Michael Ellerman <michael@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
Date: Thu, 06 Dec 2012 17:58:24 +1100
In-Reply-To: <30738.1321497066@neuling.org>
References: <30738.1321497066@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-11-17 at 13:31 +1100, Michael Neuling wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> powerpc/ptrace: Fix build with gcc 4.6
> 
> gcc (rightfully) complains that we are accessing beyond the
> end of the fpr array (we do, to access the fpscr).

This patch is still missing from the 3.0 stable series.

Do we need to resend ?

cheers
