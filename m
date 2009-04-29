Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f172.google.com (mail-gx0-f172.google.com
	[209.85.217.172]) by ozlabs.org (Postfix) with ESMTP id D01F3DDF78
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 23:38:15 +1000 (EST)
Received: by gxk20 with SMTP id 20so2382722gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 06:38:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <49F801AF.1060404@246tNt.com>
References: <20090428165015.1410.47926.stgit@localhost.localdomain>
	<49F801AF.1060404@246tNt.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 29 Apr 2009 07:37:48 -0600
Message-ID: <fa686aa40904290637g6a28e941p806b35e919f65270@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Update MPC5xxx and Xilinx Virtex maintainer
	entries
To: Sylvain Munaut <tnt@246tnt.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 29, 2009 at 1:28 AM, Sylvain Munaut <tnt@246tnt.com> wrote:
> Grant Likely wrote:
>> From: Grant Likely <grant.likely@secretlab.ca>
>>
>> - Add git tree URLs
>> - Drop Sylvain from the 5xxx maintainers list. =A0He hasn't been active
>> =A0 for a while now.
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>
> Confirmed.

Thanks Sylvain.

g.

>
>> ---
>>
>> =A0MAINTAINERS | =A0 =A04 ++--
>> =A01 files changed, 2 insertions(+), 2 deletions(-)
>>
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ef03abe..4a8d367 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3434,11 +3434,10 @@ L: =A0 =A0linuxppc-dev@ozlabs.org
>> =A0S: =A0 Maintained
>>
>> =A0LINUX FOR POWERPC EMBEDDED MPC5XXX
>> -P: =A0 Sylvain Munaut
>> -M: =A0 tnt@246tNt.com
>> =A0P: =A0 Grant Likely
>> =A0M: =A0 grant.likely@secretlab.ca
>> =A0L: =A0 linuxppc-dev@ozlabs.org
>> +T: =A0 git git://git.secretlab.ca/git/linux-2.6.git
>> =A0S: =A0 Maintained
>>
>> =A0LINUX FOR POWERPC EMBEDDED PPC4XX
>> @@ -3456,6 +3455,7 @@ P: =A0 =A0 =A0Grant Likely
>> =A0M: =A0 grant.likely@secretlab.ca
>> =A0W: =A0 http://wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex
>> =A0L: =A0 linuxppc-dev@ozlabs.org
>> +T: =A0 git git://git.secretlab.ca/git/linux-2.6.git
>> =A0S: =A0 Maintained
>>
>> =A0LINUX FOR POWERPC EMBEDDED PPC8XX
>>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
