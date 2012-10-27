Return-Path: <cbouatmailru@gmail.com>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C31F12C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Oct 2012 12:15:53 +1100 (EST)
Received: by mail-pb0-f51.google.com with SMTP id rp16so2868125pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2012 18:15:51 -0700 (PDT)
Date: Fri, 26 Oct 2012 18:12:50 -0700
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Huang Changming-R66093 <r66093@freescale.com>
Subject: Re: [PATCH] powerpc/esdhc: enable the card insert/remove interrupt
Message-ID: <20121027011249.GB9152@lizard>
References: <1350975677-8195-1-git-send-email-r66093@freescale.com>
 <20121023082648.GA21690@lizard>
 <110EED8CC96DFC488B7E717A2027A27C1C68D9@039-SN1MPN1-003.039d.mgd.msft.net>
 <110EED8CC96DFC488B7E717A2027A27C1D7A42@039-SN1MPN1-003.039d.mgd.msft.net>
 <20121025103038.GA5107@lizard>
 <110EED8CC96DFC488B7E717A2027A27C1DFBFB@039-SN1MPN1-004.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <110EED8CC96DFC488B7E717A2027A27C1DFBFB@039-SN1MPN1-004.039d.mgd.msft.net>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Chris Ball <cjb@laptop.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Huang,

On Fri, Oct 26, 2012 at 02:42:36AM +0000, Huang Changming-R66093 wrote:
> For the current polling mode, driver will send CMD13 to poll the card status periodically , which will cause too many interrupts.
> Once I sent patches to detect the card when using polling mode last year: read the state register, instead of send CMD13. But, these patches were not accepted. Now I attach them for you.

Was there any specific reason why the patches didn't get accepted?

I very briefly looked at them, and they seem to be OK (there are a few
cosmetic details I'd comment on, tho -- but please send them in a normal
way (i.e. not as attachments).

Thanks,
Anton.
