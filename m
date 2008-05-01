Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18457.22551.705318.772517@cargo.ozlabs.ibm.com>
Date: Thu, 1 May 2008 15:41:43 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'powerpc-next' branch
In-Reply-To: <Pine.LNX.4.64.0805010003510.8224@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0805010003510.8224@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> Please pull from 'powerpc-next' branch of
> 
> 	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git powerpc-next
> 
> to receive the following updates:

I assume you want me to send these on to Linus before the merge window
closes.  But this one:

> Kumar Gala (1):
>       [POWERPC] Set lower flag bits in regs->trap to indicate debug level exception

needs a bit more motivation, since it is very new, and the commit
message doesn't say why we want to do what the commit does.  What good
thing will happen, or what bad thing will be averted, by having this
commit in 2.6.26?

Paul.
