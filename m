Return-Path: <cody@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5B3271400C5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Mar 2014 05:19:37 +1100 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Tue, 25 Mar 2014 12:19:34 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 48FA81FF003B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Mar 2014 12:19:32 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2PIIvcb63242478
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Mar 2014 19:18:57 +0100
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2PIJVPP031440
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Mar 2014 12:19:31 -0600
Message-ID: <5331C8A3.7070204@linux.vnet.ibm.com>
Date: Tue, 25 Mar 2014 11:19:15 -0700
From: Cody P Schafer <cody@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH v4 09/11] powerpc/perf: add support for the hv 24x7
 interface
References: <1394064082-6242-1-git-send-email-cody@linux.vnet.ibm.com>
 <1394064082-6242-10-git-send-email-cody@linux.vnet.ibm.com>
 <20140325214356.4a2f7d95@kryten>
In-Reply-To: <20140325214356.4a2f7d95@kryten>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Michael Ellerman <michael@ellerman.id.au>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, scottwood@freescale.com,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/25/2014 03:43 AM, Anton Blanchard wrote:
>
> Hi Cody,
>
> hv-24x7: could not obtain capabilities, error 0x                                                                fffffffffffffffe, not enabling
> hv-gpci: could not obtain capabilities, error 0x                                                                fffffffffffffffe, not enabling
>
>> +		pr_info("could not obtain capabilities, error 0x%80lx, not enabling\n",
>
> That's a lot of padding :)
>
> I think this should also be a pr_debug, considering this is not relevant
> to most ppc64 boxes.

I'm fine with that. It should probably be "0x%08lx" not "0x%80lx", not 
sure when I screwed that up.
