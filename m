Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/9] powerpc: Fix msr setting in 32 bit signal code 
In-reply-to: <DB1B686B-FE98-486B-B345-D18408C51135@kernel.crashing.org> 
References: <20080618004733.BD2C870292@localhost.localdomain>
	<DB1B686B-FE98-486B-B345-D18408C51135@kernel.crashing.org>
Date: Thu, 19 Jun 2008 09:55:34 +1000
Message-ID: <13544.1213833334@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <DB1B686B-FE98-486B-B345-D18408C51135@kernel.crashing.org> you wrote:
> 
> On Jun 17, 2008, at 7:47 PM, Michael Neuling wrote:
> 
> > If we set the SPE MSR bit in save_user_regs we can blow away the VEC
> > bit.  This will never happen in reality, but it looks bad.
> >
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > ---
> >
> > arch/powerpc/kernel/signal_32.c |   10 ++++++----
> > 1 file changed, 6 insertions(+), 4 deletions(-)
> 
> probably worth commenting on why this will never happen.

Ok, I'll update the comments.

Mikey
