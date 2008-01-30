Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BB9A2DDE01
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 08:20:51 +1100 (EST)
Date: Wed, 30 Jan 2008 22:20:30 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: x86/non-x86: percpu, node ids, apic ids x86.git fixup
Message-ID: <20080130212030.GA12269@elte.hu>
References: <20080130180623.GA24881@elte.hu>
	<1FE6DD409037234FAB833C420AA843EC757DEA@orsmsx424.amr.corp.intel.com>
	<47A0CD4B.5040706@sgi.com>
	<1FE6DD409037234FAB833C420AA843EC757F12@orsmsx424.amr.corp.intel.com>
	<20080130194616.GA19426@elte.hu>
	<1FE6DD409037234FAB833C420AA843EC757F7C@orsmsx424.amr.corp.intel.com>
	<20080130200221.GA28073@elte.hu>
	<1FE6DD409037234FAB833C420AA843EC757FC2@orsmsx424.amr.corp.intel.com>
	<20080130205915.GA4562@elte.hu>
	<1FE6DD409037234FAB833C420AA843EC758076@orsmsx424.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1FE6DD409037234FAB833C420AA843EC758076@orsmsx424.amr.corp.intel.com>
Cc: sparclinux@vger.kernel.org, linux-ia64@vger.kernel.org,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Mike Travis <travis@sgi.com>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Luck, Tony <tony.luck@intel.com> wrote:

> I'll start digging on why this doesn't boot ... but you might as well 
> send the fixes so far upstream to Linus so that the SMP fix is 
> available (which is all anyone really cares about ... there are very, 
> very few UP ia64 systems in existence).
> 
> Acked-by: Tony Luck <tony.luck@intel.com>

thanks alot! Can i also add your Acked-by to this patch:

  Subject: ia64: use generic percpu
  From: travis@sgi.com

it seems like a sensible cleanup to me.

	Ingo
