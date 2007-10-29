Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18213.20275.927017.134838@cargo.ozlabs.ibm.com>
Date: Mon, 29 Oct 2007 14:10:43 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: [POWERPC] Fix off-by-one error in setting decrementer on Book E
In-Reply-To: <18213.19469.827909.663373@cargo.ozlabs.ibm.com>
References: <18213.19469.827909.663373@cargo.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I wrote:

> @@ -601,10 +601,8 @@ void timer_interrupt(struct pt_regs * regs)

That should be

@@ -601,8 +601,6 @@ void timer_interrupt(struct pt_regs * regs)

of course.

Paul.
