Return-Path: <paul.gortmaker@gmail.com>
Received: from mail-we0-x22a.google.com (mail-we0-x22a.google.com
 [IPv6:2a00:1450:400c:c03::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5F7372C008F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jan 2014 13:27:29 +1100 (EST)
Received: by mail-we0-f170.google.com with SMTP id u57so8861018wes.29
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 18:27:22 -0800 (PST)
MIME-Version: 1.0
Sender: paul.gortmaker@gmail.com
In-Reply-To: <1390348085.5027.18.camel@smoke>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
 <1390339396-3479-11-git-send-email-paul.gortmaker@windriver.com>
 <1390348085.5027.18.camel@smoke>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Tue, 21 Jan 2014 21:26:52 -0500
Message-ID: <CAP=VYLp5UiVJYxtpAcptoqdvgYD_Z=5CMBxmKekXEeSSBgFS9Q@mail.gmail.com>
Subject: Re: [PATCH 10/73] powerpc: use device_initcall for registering rtc
 devices
To: Geoff Levand <geoff@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch <linux-arch@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 21, 2014 at 6:48 PM, Geoff Levand <geoff@infradead.org> wrote:
> Hi Paul,
>
> On Tue, 2014-01-21 at 16:22 -0500, Paul Gortmaker wrote:
>> Currently these two RTC devices are in core platform code
>> where it is not possible for them to be modular.  It will
>> never be modular, so using module_init as an alias for
>> __initcall can be somewhat misleading.
>>
>>  arch/powerpc/kernel/time.c        | 2 +-
>>  arch/powerpc/platforms/ps3/time.c | 3 +--
>>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> I tested the PS3 part of this patch and it seems to work OK.
>
> Acked-by: Geoff Levand <geoff@infradead.org>

Thanks Geoff for the review and testing; I'll add the ack.

Paul.
--

>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
