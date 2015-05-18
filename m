Return-Path: <hmyneni@gmail.com>
Received: from mail-la0-x22f.google.com (mail-la0-x22f.google.com
 [IPv6:2a00:1450:4010:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BCC791A006F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 18:18:42 +1000 (AEST)
Received: by labbd9 with SMTP id bd9so207901055lab.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 01:18:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150518081106.GW2462@suse.de>
References: <CACgMoiK61mKYFpfhhK51uvkvFHK3k+Dz4peMnbeW7-npDu4XBQ@mail.gmail.com>
 <20150514093304.GS2462@suse.de>
 <CACgMoiKzcDFTd7_howiH1KK2L-ky2S4x99-FTGS9pgO9Bqi0xg@mail.gmail.com>
 <CACgMoiKOQQXfnYK_QVLMQxy9R6rJtbHPNN+w4KrnoKYRiQDPEg@mail.gmail.com>
 <20150518081106.GW2462@suse.de>
Date: Mon, 18 May 2015 01:18:36 -0700
Message-ID: <CACgMoi+r=2YaQ69QDcWUfFocornUy6Fzq3+OvWQS10wEt7-yxQ@mail.gmail.com>
Subject: Re: mm: BUG_ON with NUMA_BALANCING (kernel BUG at
 include/linux/swapops.h:131!)
From: Haren Myneni <hmyneni@gmail.com>
To: Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset=UTF-8
Cc: srikar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 5/18/15, Mel Gorman <mgorman@suse.de> wrote:
> On Mon, May 18, 2015 at 12:32:29AM -0700, Haren Myneni wrote:
>> Mel,
>>     I am hitting this issue with 4.0 kernel and even with 3.19 and
>> 3.17 kernels. I will also try with previous versions. Please let me
>> know any suggestions on the debugging.
>>
>
> Please keep going further back in time to see if there was a point where
> this was ever working. It could be a ppc64-specific bug but right now,
> I'm still drawing a blank.

Sure, will do. I am running PPC64 LE kernel, but it does not show any
LE issue so far.

Thanks
Haren

>
> --
> Mel Gorman
> SUSE Labs
>
