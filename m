Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A25751A0035
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 16:35:09 +1100 (AEDT)
Received: by mail-pa0-x234.google.com with SMTP id fl4so25957287pad.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 21:35:09 -0800 (PST)
Received: from cotter.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id a21sm8790501pfj.40.2016.02.24.21.35.06
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLSv1/SSLv3 cipher=OTHER);
 Wed, 24 Feb 2016 21:35:07 -0800 (PST)
Subject: Re: [PATCH V4 04/18] powerpc/mm: Split pgtable types to separate
 header
To: linuxppc-dev@lists.ozlabs.org
References: <1456202900-5454-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1456202900-5454-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160225031240.GC18753@oak.ozlabs.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56CE9287.7080509@gmail.com>
Date: Thu, 25 Feb 2016 16:35:03 +1100
MIME-Version: 1.0
In-Reply-To: <20160225031240.GC18753@oak.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 25/02/16 14:12, Paul Mackerras wrote:
> On Tue, Feb 23, 2016 at 10:18:06AM +0530, Aneesh Kumar K.V wrote:
>> We move the page table accessors into a separate header. We will
>> later add a big endian variant of the table which is needed for radix.
>> No functionality change only code movement.
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Reviewed-by: Paul Mackerras <paulus@samba.org>
>
> We may end up using a big-endian Linux page table even on hash,
> for the sake of simplicity.
>
Doesn't the series you posted, do that? Assuming those patches are
applied before these

Balbir Singh
