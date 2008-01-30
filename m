Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C29AADE031
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 07:02:39 +1100 (EST)
Date: Wed, 30 Jan 2008 21:02:21 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: x86/non-x86: percpu, node ids, apic ids x86.git fixup
Message-ID: <20080130200221.GA28073@elte.hu>
References: <Pine.LNX.4.64.0801301622460.11859@vixen.sonytel.be>
	<47A09F8A.3000309@sgi.com> <20080130161036.GA12293@elte.hu>
	<1FE6DD409037234FAB833C420AA843EC757C72@orsmsx424.amr.corp.intel.com>
	<20080130180623.GA24881@elte.hu>
	<1FE6DD409037234FAB833C420AA843EC757DEA@orsmsx424.amr.corp.intel.com>
	<47A0CD4B.5040706@sgi.com>
	<1FE6DD409037234FAB833C420AA843EC757F12@orsmsx424.amr.corp.intel.com>
	<20080130194616.GA19426@elte.hu>
	<1FE6DD409037234FAB833C420AA843EC757F7C@orsmsx424.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1FE6DD409037234FAB833C420AA843EC757F7C@orsmsx424.amr.corp.intel.com>
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

> > ah, that was the vital clue. The patch below makes the small memory 
> > model only defined on SMP, and makes the config build/link fine here. 
> > Does this build and boot on your box?
> 
> I applied this on top of the git pull from
>  git://git.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-x86.git
> 
> and I see see a build problem for SMP=n :-(

could you send the .config you are using?

	Ingo
