Return-Path: <namhyung@gmail.com>
Received: from mail-ob0-x22a.google.com (mail-ob0-x22a.google.com
 [IPv6:2607:f8b0:4003:c01::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A6ADE1A0DED
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 01:01:53 +1000 (AEST)
Received: by obew15 with SMTP id w15so9642562obe.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 08:01:51 -0700 (PDT)
MIME-Version: 1.0
Sender: namhyung@gmail.com
In-Reply-To: <20150527144101.GM7484@tassilo.jf.intel.com>
References: <1432080130-6678-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1432080130-6678-5-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150527135928.GB29557@danjae.kornet>
 <20150527144101.GM7484@tassilo.jf.intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 28 May 2015 00:01:31 +0900
Message-ID: <CAM9d7cjxrH6vxoJ1Cui62BRHNgxK=NSH-LyQxfULpz6oVvsn+w@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf: Add power8 PMU events in JSON format
To: Andi Kleen <ak@linux.intel.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 27, 2015 at 11:41 PM, Andi Kleen <ak@linux.intel.com> wrote:
>> > +  {
>> > +    "EventCode": "0x2505e",
>> > +    "EventName": "PM_BACK_BR_CMPL",
>> > +    "BriefDescription": "Branch instruction completed with a target address less than current instruction address,",
>> > +    "PublicDescription": "Branch instruction completed with a target address less than current instruction address.,"
>>
>> Can't we remove PublicDescription field if it's identical to
>> BriefDescription?  It seems just wasting spaces..
>
> It's not always identical. There are events where PublicDescription is much longer (several paragraphs)

I know.  What I said is make it optional so that we can drop if it's identical.

Thanks,
Namhyung
