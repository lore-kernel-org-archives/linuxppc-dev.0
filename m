Return-Path: <valentinrothberg@gmail.com>
Received: from mail-wm0-x22e.google.com (mail-wm0-x22e.google.com
 [IPv6:2a00:1450:400c:c09::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F7B11A0657
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 20:52:00 +1100 (AEDT)
Received: by mail-wm0-x22e.google.com with SMTP id n186so21178952wmn.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 01:51:59 -0800 (PST)
Date: Fri, 11 Dec 2015 10:51:54 +0100
From: Valentin Rothberg <valentinrothberg@gmail.com>
To: Daniel Axtens <dja@axtens.net>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org
Subject: Re: [PATCH] arch/powerpc/Kconfig: fix typo in select statement
Message-ID: <20151211095154.GB28234@i4lab-dhcp156.informatik.uni-erlangen.de>
References: <1449819988-28603-1-git-send-email-valentinrothberg@gmail.com>
 <87a8phjtcf.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <87a8phjtcf.fsf@gamma.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Daniel,

thank you for the links and the explanation.

On Dec 11 '15 19:13, Daniel Axtens wrote:
> Thanks Valentin.
> 
> Ironically I first noticed the spelling mistake in the original UBSAN
> patchset[1], but wanted it to work on powerpc straight away so I went
> with the mis-spelled version. It's since been corrected upstream[2]; and
> I was going to spin a v2 of my original patch with this fix, especially
> since I tagged the original patch as an RFC only. Regardless, thank you:
> this should keep -mm and next working in the mean time!

I haven't seen the fix, sorry for the noise then.

> > Fixes: 257e4ee82dbd ("powerpc: enable UBSAN support")
> Is this a SHA from linux-next?

Yes, it's Linux next.  Retrospectively, that was a bad idea :(

Kind regards,
 Valentin
