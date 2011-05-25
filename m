Return-Path: <lethal@linux-sh.org>
Received: from linux-sh.org (linux-sh.org [111.68.239.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 83792B6F8D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 May 2011 12:59:38 +1000 (EST)
Date: Wed, 25 May 2011 11:27:23 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH v2] hw_breakpoint: Let the user choose not to build it
	(and perf too)
Message-ID: <20110525022723.GE14329@linux-sh.org>
References: <1306273947-8410-1-git-send-email-fweisbec@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306273947-8410-1-git-send-email-fweisbec@gmail.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linuxppc-dev@lists.ozlabs.org,
	"H . Peter Anvin" <hpa@zytor.com>, Will Deacon <will.deacon@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Ingo Molnar <mingo@elte.hu>, Prasad <prasad@linux.vnet.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 24, 2011 at 11:52:21PM +0200, Frederic Weisbecker wrote:
> Mostly just a rebase against latest upstream
> updates and acks from Will Deacon added In this second version.
> 
> Please tell me if you are ok with this set.
> 
> Thanks.
> 
> ---
> 
> Frederic Weisbecker (6):
>       hw_breakpoints: Split hardware breakpoints config
>       hw_breakpoints: Migrate breakpoint conditional build under new config
>       x86: Allow the user not to build hw_breakpoints
>       hw_breakpoints: Breakpoints arch ability don't need perf events
>       hw_breakpoints: Only force perf events if breakpoints are selected
>       hw_breakpoints: Drop remaining misplaced dependency on perf
> 
The series looks good to me:

Acked-by: Paul Mundt <lethal@linux-sh.org>
