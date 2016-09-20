Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdSWM494tzDsTW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 13:13:19 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id oz2so248594pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 20:13:19 -0700 (PDT)
Subject: Re: [PATCH] powerpc/mm: Update the FORCE_MAX_ZONEORDER range to
 enable hugetlb
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1474306293-15390-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <2d14a740-2345-99d0-4d7e-ae052d416f6d@gmail.com>
 <871t0fxoxr.fsf@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <02de1513-b7de-39f1-fe3c-066014107560@gmail.com>
Date: Tue, 20 Sep 2016 13:13:11 +1000
MIME-Version: 1.0
In-Reply-To: <871t0fxoxr.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 20/09/16 12:52, Aneesh Kumar K.V wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
> 
>> On 20/09/16 03:31, Aneesh Kumar K.V wrote:
[...]
>>
>> Do we need the range to be 12 13?
> 
> static inline bool hstate_is_gigantic(struct hstate *h)
> {
> 	return huge_page_order(h) >= MAX_ORDER;
> }
> 
> We consider hstate gigantic if it also == MAX_ORDER. Hence it should
> be > 12 .
> 

Good point, agreed

Balbir Singh.
