Return-Path: <pku.leo@gmail.com>
Received: from mail-lb0-f171.google.com (mail-lb0-f171.google.com
 [209.85.217.171])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B62751400D5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Apr 2014 15:53:12 +1000 (EST)
Received: by mail-lb0-f171.google.com with SMTP id u14so1685556lbd.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Apr 2014 22:53:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1398462328.24575.20.camel@snotra.buserror.net>
References: <1398319908-30166-1-git-send-email-dongsheng.wang@freescale.com>
 <1398462328.24575.20.camel@snotra.buserror.net>
Date: Mon, 28 Apr 2014 13:53:06 +0800
Message-ID: <CADRPPNTGRyLSSjcdpdZL95NVnRepR_ZqvVk1zrMU3ZOL0_bbNQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] powerpc/pm: add api to get suspend state which is
 STANDBY or MEM
From: Leo Li <pku.leo@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Dongsheng Wang <dongsheng.wang@freescale.com>,
 =?UTF-8?B?5q2j6ZuEIOmHkQ==?= <jason.jin@freescale.com>,
 Zhao Chenhui <chenhui.zhao@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Apr 26, 2014 at 5:45 AM, Scott Wood <scottwood@freescale.com> wrote:
> On Thu, 2014-04-24 at 14:11 +0800, Dongsheng Wang wrote:
>> From: Wang Dongsheng <dongsheng.wang@freescale.com>
>>
>> Add set_pm_suspend_state & pm_suspend_state functions to set/get
>> suspend state. When system going to sleep or deep sleep, devices
>> can get the system suspend state(STANDBY/MEM) through pm_suspend_state
>> function and to handle different situations.
>>
>> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
>> ---
>> *v2*
>> Move pm api from fsl platform to powerpc general framework.
>
> What is powerpc-specific about this?

Generally I agree with you.  But I had the discussion about this topic
a while ago with the PM maintainer.  He suggestion to go with the
platform way.

https://lkml.org/lkml/2013/8/16/505

Regards,
Leo
