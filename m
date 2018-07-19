Return-Path: <geoff@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41WcyW1lCvzDqCH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 01:15:14 +1000 (AEST)
Subject: Re: Improvements for the PS3
To: Geert Uytterhoeven <geert@linux-m68k.org>, noring@nocrew.org
Cc: linuxppc-dev@lists.ozlabs.org
References: <20180714164906.GQ23412@localhost.localdomain>
 <7d6362d7-da99-e57f-40ed-81c7a03ea1a4@infradead.org>
 <CAMuHMdX3xiRYYdhQftHRDYFqob7xMHm-xxvh3NyoC1TowH4x8g@mail.gmail.com>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <d56c408d-347e-ae94-c2ea-331343660147@infradead.org>
Date: Thu, 19 Jul 2018 08:15:12 -0700
MIME-Version: 1.0
In-Reply-To: <CAMuHMdX3xiRYYdhQftHRDYFqob7xMHm-xxvh3NyoC1TowH4x8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Geert, Fredrik,

On 07/19/2018 12:45 AM, Geert Uytterhoeven wrote:
>> On 07/14/2018 09:49 AM, Fredrik Noring wrote:
>>>
>>> et voilà, the screen came alive and the kernel panic was revealed! It seems
>>> the kernel panics so fast that the PS3 frame buffer is unprepared. This is,
>>> of course, very unfortunate because trying to debug the boot process without
>>> a screen or any other means of obtaining console text is quite difficult.
>>
> What about letting ps3fb register a panic notifier to sync the screen, like
> hyperv_fb does?

Seems like the thing to do.  Fredrik, do you want to try it?  Otherwise, I'll
work on it when I have some time.

-Geoff
