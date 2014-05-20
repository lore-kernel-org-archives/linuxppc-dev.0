Return-Path: <peerlessdeepaks@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6B9991A0852
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 18:10:17 +1000 (EST)
Received: from mail-wg0-x231.google.com (mail-wg0-x231.google.com
 [IPv6:2a00:1450:400c:c00::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 99BBF14007E
 for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2014 18:10:16 +1000 (EST)
Received: by mail-wg0-f49.google.com with SMTP id m15so126738wgh.32
 for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2014 01:10:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5167457E.1050205@genband.com>
References: <5167457E.1050205@genband.com>
From: Deepak Pandian <peerlessdeepaks@gmail.com>
Date: Tue, 20 May 2014 13:39:52 +0530
Message-ID: <CAAK7kEEHCBm5JLvYKOsqWcXpWK9pLD1tC82+jn7NYb2t_O19vQ@mail.gmail.com>
Subject: Re: questions on CONFIG_PPC_ADV_DEBUG_REGS, DBCR0_BRT,
 and DBCR0_ACTIVE_EVENTS
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

unsubcribe linuxppc-dev

On Fri, Apr 12, 2013 at 4:51 AM, Chris Friesen
<chris.friesen@genband.com> wrote:
> Hi all,
>
> Sorry for the bunch of emails, I'm working on some new stuff and running
> into issues.
>
> For CONFIG_BOOKE it appears that DBCR0_ACTIVE_EVENTS includes DBCR0_ICMP but
> not DBCR0_BRT.  Is that just because none of the code paths currently using
> DBCR0_ACTIVE_EVENTS need to check DBCR0_BT?
>
> Also, in sys_debug_setcontext() why does SIG_DBG_BRANCH_TRACING return
> -EINVAL if CONFIG_PPC_ADV_DEBUG_REGS is set?  Would it not be possible to
> use DBCR0_BRT?
>
> Thanks,
> Chris
>
> --
>
> Chris Friesen
> Software Designer
>
> 500 Palladium Drive, Suite 2100
> Ottawa, Ontario K2N 1C2, Canada
> www.genband.com
> office:+1.343.883.2717
> chris.friesen@genband.com
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev



-- 
With Regards,
Deepak Pandian
"Deconstructing world one piece at a time"
