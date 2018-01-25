Return-Path: <frowand.list@gmail.com>
Received: from mail-it0-x22a.google.com (mail-it0-x22a.google.com
 [IPv6:2607:f8b0:4001:c0b::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zRwGW6K7CzDqvh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jan 2018 19:30:43 +1100 (AEDT)
Received: by mail-it0-x22a.google.com with SMTP id b5so8359636itc.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jan 2018 00:30:43 -0800 (PST)
Subject: Re: [RFC PATCH v2 1/1] of: introduce event tracepoints for dynamic
 device_node lifecyle
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Rob Herring <robh+dt@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180121143117.19805-1-wsa+renesas@sang-engineering.com>
 <20180121143117.19805-2-wsa+renesas@sang-engineering.com>
 <4cc627c4-1aaf-b8d5-5a26-eea7e596743f@gmail.com>
 <CAMuHMdVuN5iRLqWuPH_UVR1zDJK-rPHZ6guU-ssPuoZ=UWTAFw@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <ba2b76ee-f048-496c-eb3a-b9060b6701b7@gmail.com>
Date: Thu, 25 Jan 2018 00:30:39 -0800
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVuN5iRLqWuPH_UVR1zDJK-rPHZ6guU-ssPuoZ=UWTAFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/25/18 00:01, Geert Uytterhoeven wrote:
> Hi Frank,
> 
> On Thu, Jan 25, 2018 at 7:48 AM, Frank Rowand <frowand.list@gmail.com> wrote:
>>>  create mode 100644 include/trace/events/of.h
>>
>> mode looks incorrect.  Existing files in include/trace/events/ are -rw-rw----
> 
> Not in my git clone ;-) 644 should be fine.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert

Thanks!!!  I just learned something new about git.  Now I have to go experiment
a bit to make sure I learned properly.

-Frank
