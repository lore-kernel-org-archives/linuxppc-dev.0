Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 679972C013F
 for <linuxppc-dev@ozlabs.org>; Sat, 21 Sep 2013 16:46:56 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Sat, 21 Sep 2013 12:16:53 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id F40A2E0040
 for <linuxppc-dev@ozlabs.org>; Sat, 21 Sep 2013 12:17:50 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8L6km6A48234678
 for <linuxppc-dev@ozlabs.org>; Sat, 21 Sep 2013 12:16:48 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8L6knGi009313
 for <linuxppc-dev@ozlabs.org>; Sat, 21 Sep 2013 12:16:50 +0530
Message-ID: <523D40A3.4050906@linux.vnet.ibm.com>
Date: Sat, 21 Sep 2013 12:15:55 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH V2 0/6] perf: New conditional branch filter
References: <1377836690-32710-1-git-send-email-khandual@linux.vnet.ibm.com>
 <CABPqkBS2AD873tHnyCHeC7uwsJdP1V6=8WGUTHG+R0z2pphHjQ@mail.gmail.com>
 <523D3FA2.2070209@linux.vnet.ibm.com>
In-Reply-To: <523D3FA2.2070209@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: LKML <linux-kernel@vger.kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, ellerman@au1.ibm.com,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, michael.neuling@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/21/2013 12:11 PM, Anshuman Khandual wrote:
> On 08/30/2013 05:18 PM, Stephane Eranian wrote:
>> 2013/8/30 Anshuman Khandual <khandual@linux.vnet.ibm.com>
>>>>
>>>>         This patchset is the re-spin of the original branch stack sampling
>>>> patchset which introduced new PERF_SAMPLE_BRANCH_COND filter. This patchset
>>>> also enables SW based branch filtering support for PPC64 platforms which have
>>>> branch stack sampling support. With this new enablement, the branch filter support
>>>> for PPC64 platforms have been extended to include all these combinations discussed
>>>> below with a sample test application program.
>>>>
>>>>
>> I am trying to understand which HW has support for capturing the
>> branches: PPC7 or PPC8.
>> Then it seems you're saying that only PPC8 has the filtering support.
>> On PPC7 you use the
>> SW filter. Did I get this right?
>>
>> I will look at the patch set.
>>
> 
> Hey Stephane,
> 
> Just wondering if you got a chance to go though the patchset ?


s/though/through/
