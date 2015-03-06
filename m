Return-Path: <olof@lixom.net>
Received: from mail-oi0-f51.google.com (mail-oi0-f51.google.com
 [209.85.218.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA2031A018B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Mar 2015 10:50:13 +1100 (AEDT)
Received: by oiax69 with SMTP id x69so20420559oia.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Mar 2015 15:50:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1425682582.4636.197.camel@kernel.crashing.org>
References: <20150305171239.3a8135e6@gandalf.local.home>
 <1425615522.4636.173.camel@kernel.crashing.org>
 <20150306100021.5637d790@gandalf.local.home>
 <1425682582.4636.197.camel@kernel.crashing.org>
Date: Fri, 6 Mar 2015 15:50:10 -0800
Message-ID: <CAOesGMjBjmVQtdA85Uc2QrVT6enVShOx-iyXdZLvH9vuq8t=wQ@mail.gmail.com>
Subject: Re: [REGRESSION in 3.18][PPC] PA Semi fails to boot after: of/base:
 Fix PowerPC address parsing hack
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <robh@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 6, 2015 at 2:56 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2015-03-06 at 10:00 -0500, Steven Rostedt wrote:
>> On Fri, 06 Mar 2015 15:18:42 +1100
>> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>>
>>
>> > Can you shoot me the DT (/proc/device-tree in a tarball) ?
>>
>> Attached.
>
> This is indeed a bug in their DT. We might want to add quirks for
> that unless it can be fixed (or has been via FW update). Olof ?

FW updates on this platform are highly unlikely. Quirk it is.


-Olof
