Return-Path: <larry.finger@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tkvdz6W3SzDwKp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Dec 2016 01:53:11 +1100 (AEDT)
Received: from mail-oi0-x242.google.com (mail-oi0-x242.google.com
 [IPv6:2607:f8b0:4003:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tkvdz2Jc6z9t0Z
 for <linuxppc-dev@ozlabs.org>; Fri, 23 Dec 2016 01:53:11 +1100 (AEDT)
Received: by mail-oi0-x242.google.com with SMTP id v84so32615373oie.2
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Dec 2016 06:53:11 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: Build warning on 32-bit PPC - bisected to commit 989cea5c14be
To: Nicholas Piggin <npiggin@gmail.com>
References: <53d94073-6e7e-af83-a29a-e811ab5fd802@lwfinger.net>
 <20161222120224.36202396@roar.ozlabs.ibm.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>, Michal Marek
 <mmarek@suse.com>, LKML <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <975651aa-16b7-7e85-67d0-325e590ff0ed@lwfinger.net>
Date: Thu, 22 Dec 2016 08:53:07 -0600
MIME-Version: 1.0
In-Reply-To: <20161222120224.36202396@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/21/2016 08:02 PM, Nicholas Piggin wrote:
> Hi Larry,
>
> This is strange you've bisected it there, I can't see how that patch would
> trigger it. That said, powerpc has had a few small build system glitches.
>
> It looks like this warning could be fixed by changing #elif CONFIG_FSL_BOOKE
> to #elif defined (CONFIG_FSL_BOOKE). Want to send a patch (if it works)?

Nick,

I agree that the "bad" commit does not look likely to be the problem, but I 
verified it by checking out the previous commit, which does not show the 
problem. I'm quite sure that PowerPC has a lot of quirks and glitches beyond 
those caused by the Apple hardware.

I have tested the change and I will submit the patch.

Thanks,

Larry
