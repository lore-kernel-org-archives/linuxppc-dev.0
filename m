Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18200.41484.605753.150546@cargo.ozlabs.ibm.com>
Date: Fri, 19 Oct 2007 22:24:44 +1000
From: Paul Mackerras <paulus@samba.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v2 3/4] Implement clockevents driver for powerpc
In-Reply-To: <471899D1.2000903@ru.mvista.com>
References: <20070921032603.0D3EA32C887@thor> <4713A616.3090103@ru.mvista.com>
	<18195.64334.985238.848522@cargo.ozlabs.ibm.com>
	<47161D79.6000003@ru.mvista.com>
	<18198.43687.44059.477047@cargo.ozlabs.ibm.com>
	<47177229.2030200@ru.mvista.com>
	<18199.63230.583536.307945@cargo.ozlabs.ibm.com>
	<471899D1.2000903@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sergei Shtylyov writes:

>     BTW, why not handle the decrementer difference right in set_dec() where we 
> already have #ifdef'ed code?

Excellent idea.  Let's do that.

Paul.
