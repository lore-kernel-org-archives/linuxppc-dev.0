Return-Path: <torvalds@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 691E7DDDF7
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Aug 2007 14:41:31 +1000 (EST)
Date: Sat, 4 Aug 2007 21:41:08 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Paul Collins <paul@briny.ondioline.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: "Badness at kernel/irq/resend.c:70" on boot - via-pmu?
In-Reply-To: <87sl6ypsx2.fsf@briny.wgtn.ondioline.org>
Message-ID: <alpine.LFD.0.999.0708042139300.5037@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0708032031480.5037@woody.linux-foundation.org>
	<87sl6ypsx2.fsf@briny.wgtn.ondioline.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: paulus@samba.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Sun, 5 Aug 2007, Paul Collins wrote:
> 
> I got the message below on boot with 2.6.23-rc2 on my PowerBook.

It's a debug message, I think we need to remove it. It's trying to figure 
out what goes wrong with one particular machine, and I probably shouldn't 
have merged it for mainline.

Ignore it, it will be gone soon enough, and it should happen just once per 
boot.

		Linus
