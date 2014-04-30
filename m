Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 65C0014010E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 19:52:31 +1000 (EST)
Message-ID: <5360C7D3.2090708@suse.de>
Date: Wed, 30 Apr 2014 11:52:19 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 0/6] Implement split core for POWER8
References: <1398303165-6576-1-git-send-email-mikey@neuling.org>
 <9524.1398834577@ale.ozlabs.ibm.com>
In-Reply-To: <9524.1398834577@ale.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 30.04.14 07:09, Michael Neuling wrote:
>> This patch series implements split core mode on POWER8.  This enables up to 4
>> subcores per core which can each independently run guests (per guest SPRs like
>> SDR1, LPIDR etc are replicated per subcore).  Lots more documentation on this
>> feature in the code and commit messages.
>>
>> Most of this code is in the powernv platform but there's a couple of KVM
>> specific patches too.
>>
>> Alex: If you're happy with the KVM patches, please ACK them and benh can hold
>> this series.
> Alex,
>
> Any chance we can get an ACK on these two KVM patches so benh can put
> this series in his next branch?

For patches 1/6 and 5/6:

   Acked-by: Alexander Graf <agraf@suse.de>

However, please make sure to get Paul's ack as well.


Alex
