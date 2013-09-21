Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 593472C015D
 for <linuxppc-dev@ozlabs.org>; Sat, 21 Sep 2013 16:42:44 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Sat, 21 Sep 2013 12:12:35 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 5E8881258053
 for <linuxppc-dev@ozlabs.org>; Sat, 21 Sep 2013 12:12:43 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8L6ig6D44957924
 for <linuxppc-dev@ozlabs.org>; Sat, 21 Sep 2013 12:14:43 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8L6gWKR013678
 for <linuxppc-dev@ozlabs.org>; Sat, 21 Sep 2013 12:12:32 +0530
Message-ID: <523D3FA2.2070209@linux.vnet.ibm.com>
Date: Sat, 21 Sep 2013 12:11:38 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH V2 0/6] perf: New conditional branch filter
References: <1377836690-32710-1-git-send-email-khandual@linux.vnet.ibm.com>
 <CABPqkBS2AD873tHnyCHeC7uwsJdP1V6=8WGUTHG+R0z2pphHjQ@mail.gmail.com>
In-Reply-To: <CABPqkBS2AD873tHnyCHeC7uwsJdP1V6=8WGUTHG+R0z2pphHjQ@mail.gmail.com>
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

On 08/30/2013 05:18 PM, Stephane Eranian wrote:
> 2013/8/30 Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> >
>> >         This patchset is the re-spin of the original branch stack sampling
>> > patchset which introduced new PERF_SAMPLE_BRANCH_COND filter. This patchset
>> > also enables SW based branch filtering support for PPC64 platforms which have
>> > branch stack sampling support. With this new enablement, the branch filter support
>> > for PPC64 platforms have been extended to include all these combinations discussed
>> > below with a sample test application program.
>> >
>> >
> I am trying to understand which HW has support for capturing the
> branches: PPC7 or PPC8.
> Then it seems you're saying that only PPC8 has the filtering support.
> On PPC7 you use the
> SW filter. Did I get this right?
> 
> I will look at the patch set.
> 

Hey Stephane,

Just wondering if you got a chance to go though the patchset ?

Regards
Anshuman
