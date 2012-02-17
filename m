Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 574331007D5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 16:55:52 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Fri, 17 Feb 2012 11:25:48 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1H5tVIT3485930
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 11:25:31 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1H5tUTi000409
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 16:55:30 +1100
Message-ID: <4F3DEBCF.8000201@in.ibm.com>
Date: Fri, 17 Feb 2012 11:25:27 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH v1 0/4][makedumpfile] vmalloc translation support for PPC32
References: <20120216033411.7972.77705.stgit@suzukikp>
 <20120217093220.0c2993a1.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120217093220.0c2993a1.kumagai-atsushi@mxc.nes.nec.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux ppc dev <linuxppc-dev@lists.ozlabs.org>, kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/17/2012 06:02 AM, Atsushi Kumagai wrote:
> Hi, Suzuki
>
> On Thu, 16 Feb 2012 09:05:17 +0530
> "Suzuki K. Poulose"<suzuki@in.ibm.com>  wrote:
>
>> The series introduces an infrastructure to define platform specific
>> bits for page translation for PPC and PPC44x support for vmalloc
>> translation.
>>
>> This is similar to what we have implemented for Crash-utility.
>>
>> The patches are based makedumpfile-1.4.2 + PPC32 support patches
>> which is queued in for 1.4.3.
>>
>> ---
>>
>> Suzuki K. Poulose (4):
>>        [makedumpfile][ppc] PPC44x page translation definitions
>>        [makedumpfile][ppc] Define platform descriptors for page translation
>>        [makedumpfile][ppc] Generic vmalloc translation support
>>        [makedumpfile] Add read_string routine
>>
>>
>>   arch/ppc.c     |  108 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>>   makedumpfile.c |   14 +++++++
>>   makedumpfile.h |   21 +++++++++++
>>   3 files changed, 139 insertions(+), 4 deletions(-)
>>
>> --
>> Suzuki Poulose
>
> Could you tell me what kind of data is stored in vmalloc region in PPC ?
> I want to estimate importance of your patches for makedumpfile.
I know at least the modules are loaded in the vmalloc'd region. I have
Cc'ed linux-ppc dev. We should be able to get enough info from the experts here.

Josh / Kumar / Others,

Could you please let us know your thoughts ?

Thanks

Suzuki
