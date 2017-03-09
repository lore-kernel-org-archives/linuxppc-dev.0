Return-Path: <dja@axtens.net>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vfRtp5610zDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 10:49:06 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id v190so8775273pfb.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Mar 2017 15:49:06 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: "Tobin C. Harding" <me@tobin.cc>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: kernel versions
In-Reply-To: <20170308205249.GA1257@eros>
References: <20170308205249.GA1257@eros>
Date: Fri, 10 Mar 2017 10:48:59 +1100
Message-ID: <87shmm3tas.fsf@possimpible.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Tobin,

> Recently the kernel version on the github
> repository did not match up with the master branch of
>
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/powerpc/linux
>
> Specifically, github was hosting v4.10-rc5 while master had
> v4.10-rc8. All the while Linus' mainline was at v4.11-rc1.
>
> Was this an anomaly or is there a technical reason please? While
> writing this I see that perhaps I should have checked the other
> branches (fixes, next, test).

These are all managed by different people, and none of them are managed
by any of the linuxppc-dev folk.

Sorry I can't be more helpful.

Regards,
Daniel

>
> thanks,
> Tobin.
