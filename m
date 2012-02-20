Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 24279B6FA9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2012 21:31:15 +1100 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Mon, 20 Feb 2012 16:01:10 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1KAV5s44178150
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2012 16:01:05 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1KAV4jc018975
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2012 16:01:04 +0530
Message-ID: <4F4220E7.2060505@in.ibm.com>
Date: Mon, 20 Feb 2012 16:01:03 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH v1 0/4][makedumpfile] vmalloc translation support for PPC32
References: <20120216033411.7972.77705.stgit@suzukikp>
 <20120217093220.0c2993a1.kumagai-atsushi@mxc.nes.nec.co.jp>
 <4F3DEBCF.8000201@in.ibm.com> <1329467969.2892.58.camel@pasglop>
 <20120220185601.d08b8864.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120220185601.d08b8864.kumagai-atsushi@mxc.nes.nec.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/20/2012 03:26 PM, Atsushi Kumagai wrote:
> Hi, Benjamin
> Hi, Suzuki
>
> On Fri, 17 Feb 2012 19:39:29 +1100
> Benjamin Herrenschmidt<benh@kernel.crashing.org>  wrote:
>
>> On Fri, 2012-02-17 at 11:25 +0530, Suzuki K. Poulose wrote:
>>>> Could you tell me what kind of data is stored in vmalloc region in
>>> PPC ?
>>>> I want to estimate importance of your patches for makedumpfile.
>>> I know at least the modules are loaded in the vmalloc'd region. I have
>>> Cc'ed linux-ppc dev. We should be able to get enough info from the
>>> experts here.
>>>
>>> Josh / Kumar / Others,
>>>
>>> Could you please let us know your thoughts ?
>>
>> Modules, driver IO mappings, etc... I can see that being useful for
>> crashdumps.
>
> Thank you for your information.
>
> The above data may be required for one function of makedumpfile (filter
> out kernel data) but not so crucial for makedumpfile as page descriptors
> and related data(e.g. pglist_data).
>
> Moreover, I'm preparing the release of v1.4.3 now, so I'll merge vmalloc
> support for PPC32 into v1.4.4. Is it all right for you, Suzuki ?

Yep,  fine with me.

Thanks
Suzuki
