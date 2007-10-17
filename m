Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id 1203DDDE39
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 21:10:32 +1000 (EST)
Message-ID: <4715ED92.80503@semihalf.com>
Date: Wed, 17 Oct 2007 13:10:10 +0200
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 01/15] [POWERPC] TQM5200 DTS
References: <47075FA7.3030108@semihalf.com> <4708BFDD.9020900@semihalf.com>
	<fa686aa40710071036u164f2cbaob8cfa4ebc0b1ed1c@mail.gmail.com>
In-Reply-To: <fa686aa40710071036u164f2cbaob8cfa4ebc0b1ed1c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
>> +       memory {
>> +               device_type = "memory";
>> +               reg = <00000000 04000000>;      // 64MB
>> +       };
>> +
>> +       soc5200@f0000000 {
> 
> I think we're moving to the convetion of naming these nodes
> "soc@<addr>" now.  (You can drop the 5200 for the node name)

Seems that this will not be painless, U-boot uses hardcoded
paths with 'soc5200', so the appropriate patch will be needed.
That may be ok for new boards but what do we do with lite5200,
where U-boot upgrade is not always an option?

m.
