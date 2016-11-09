Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tDcqd1x4szDvHy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 07:15:25 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA9KDeGq027100
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Nov 2016 15:15:22 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26m3mmh47s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Nov 2016 15:15:22 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Wed, 9 Nov 2016 13:15:21 -0700
Date: Wed, 9 Nov 2016 14:15:14 -0600
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Rob Herring <robh+dt@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 4/4] of/fdt: mark hotpluggable memory
References: <1478562276-25539-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1478562276-25539-5-git-send-email-arbab@linux.vnet.ibm.com>
 <CAL_JsqLmAv4Pueq9XveeWMD3Jn_o6mGUcyztx8OajBGTrEd0aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <CAL_JsqLmAv4Pueq9XveeWMD3Jn_o6mGUcyztx8OajBGTrEd0aQ@mail.gmail.com>
Message-Id: <20161109201513.6q5fgfwkmyb2k63n@arbab-vm>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 09, 2016 at 12:12:55PM -0600, Rob Herring wrote:
>On Mon, Nov 7, 2016 at 5:44 PM, Reza Arbab <arbab@linux.vnet.ibm.com> wrote:
>> +       hotpluggable = of_get_flat_dt_prop(node, "linux,hotpluggable", NULL);
>
>Memory being hotpluggable doesn't seem like a linux property to me.
>I'd drop the linux prefix. Also, this needs to be documented.

Sure, that makes sense. I'll do both in v7.

-- 
Reza Arbab
