Return-Path: <pku.leo@gmail.com>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8B6622C0097
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2012 13:14:30 +1000 (EST)
Received: by obbeh20 with SMTP id eh20so3400962obb.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2012 20:14:27 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <B5854411-6C9A-43BA-BF5D-FB1AD76E28D1@kernel.crashing.org>
References: <1342788159-27529-1-git-send-email-chenhui.zhao@freescale.com>
 <CADRPPNSw5Yn7EgHt5fm2vYr+zxC4T+JbsvT812u2JPKELNcA6g@mail.gmail.com>
 <B5854411-6C9A-43BA-BF5D-FB1AD76E28D1@kernel.crashing.org>
Date: Fri, 27 Jul 2012 11:14:27 +0800
Message-ID: <CADRPPNRxBJX3Wgkj2aPmw8w=Ayj57CTCOkTEwBDCKwbjein1Ew@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] power management patch set
From: Li Yang <leoli@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 Zhao Chenhui <chenhui.zhao@freescale.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 27, 2012 at 1:29 AM, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Jul 26, 2012, at 9:02 AM, Li Yang wrote:
>
>> On Fri, Jul 20, 2012 at 8:42 PM, Zhao Chenhui
>> <chenhui.zhao@freescale.com> wrote:
>>> Changes for v8:
>>> * Separated the cpu hotplug patch into three patches, as follows
>>> [PATCH v8 1/7] powerpc/smp: use a struct epapr_spin_table to replace macros
>>> [PATCH v8 2/7] powerpc/smp: add generic_set_cpu_up() to set cpu_state as CPU_UP_PREPARE
>>> [PATCH v8 4/7] powerpc/85xx: add HOTPLUG_CPU support
>>>
>>> * Replaced magic numbers with macros in "[PATCH 5/7] powerpc/85xx: add sleep and deep sleep support"
>>>
>>> * no change to the rest of the patch set
>>
>> Hi Kumar,
>>
>> How about picking about this series for 3.6?  The review seems to
>> settle down for this revision.
>
> Its too late for 3.6, but will look at queuing it up for 3.7.

Too late?  The latest version were submitted on Jul 20 and you are
still picking up other patches today.  :)  I do think the patches have
been floating around for too long time to wait for another release
cycle.  If there are problems, we can work on addressing them in
follow up patches.

Leo
