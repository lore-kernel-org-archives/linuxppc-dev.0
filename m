Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17481.60598.162186.488312@cargo.ozlabs.ibm.com>
Date: Sat, 22 Apr 2006 18:43:34 +1000
From: Paul Mackerras <paulus@samba.org>
To: David Wilder <dwilder@us.ibm.com>
Subject: Re: [PATCH] kdump-ppc64-xmon-stop-cpu
In-Reply-To: <443ADCF5.60702@us.ibm.com>
References: <443ADCF5.60702@us.ibm.com>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, mchintage@in.ibm.com,
	fastboot@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Wilder writes:

> - During CPU(s) hang scenarios, kdump could not stop these CPUs. 
> However, the user could invoke soft-reset to shoot down CPUs reliably. 
> But, when the debugger is enabled, these CPUs are returned to hang state 
> after they exited from the debugger. This patch fixes this issue by 
> calling crash_kexec_secondary() before returns to previous state.

All three of your patches need a good 1-line description in the
subject and better description - one which is comprehensible to
someone who doesn't know all the internals of kdump, and with correct
English grammar.  I had to read this one about 4 times before I got
much of an idea what it was supposed to be about.  Please resubmit all
three patches in your series.

Paul.
