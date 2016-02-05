Return-Path: <kda@linux-powerpc.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8B0BA1A0279
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Feb 2016 01:49:01 +1100 (AEDT)
Received: from mail-yk0-x242.google.com (mail-yk0-x242.google.com
 [IPv6:2607:f8b0:4002:c07::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 31884140BAF
 for <linuxppc-dev@ozlabs.org>; Sat,  6 Feb 2016 01:48:59 +1100 (AEDT)
Received: by mail-yk0-x242.google.com with SMTP id z13so2647864ykd.3
 for <linuxppc-dev@ozlabs.org>; Fri, 05 Feb 2016 06:48:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20160205093647.79ca2f70@gandalf.local.home>
References: <1450124286-4822-1-git-send-email-kda@linux-powerpc.org>
 <1450124286-4822-2-git-send-email-kda@linux-powerpc.org>
 <1452599615.20985.2.camel@ellerman.id.au>
 <CAOJe8K2iVOy9=Ds09_ePct3xR6qCH0U4XoKW-qP_TNEMe8GAmQ@mail.gmail.com>
 <CAOJe8K2Ahh-y95BmpsP+d2P9ysUsyo5CnhPOXymEJzjFwkR=7Q@mail.gmail.com>
 <20160205093647.79ca2f70@gandalf.local.home>
Date: Fri, 5 Feb 2016 17:48:57 +0300
Message-ID: <CAOJe8K03+hPZx5Ov1r5WtyvgsJH3N1LV1wfYA6eBWa=qwiXrbA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] powerpc: tracing: don't trace hcalls on offline
 CPUs
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Steven Rostedt <rostedt@goodmis.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2/5/16, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Fri, 5 Feb 2016 14:20:17 +0300
> Denis Kirjanov <kda@linux-powerpc.org> wrote:
>
>> >>> Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
>> >
>> > Hi Steven,
>> >
>> > please apply with Michael's acked-by tag.
>>
>> ping
>>
>
> Actually, can you take this through the ppc tree? The
> TRACE_EVENT_FN_COND is already in mainline.
>
> You can add my:
>
> Acked-by: Steven Rostedt <rostedt@goodmis.org>

Hey Michael,

Please apply the patch.

Thanks!

>
> -- Steve
>
