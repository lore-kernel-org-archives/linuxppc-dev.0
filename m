Message-ID: <3D63F0D5.8010401@dslextreme.com>
Date: Wed, 21 Aug 2002 12:58:13 -0700
From: akuster <akuster@dslextreme.com>
Reply-To: akuster@dslextreme.com
MIME-Version: 1.0
To: Brian Kuschak <bkuschak@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 4xx ethernet and power management
References: <20020821003010.49406.qmail@web40209.mail.yahoo.com> <3D63BC50.5090801@dslextreme.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


akuster wrote:
>
> Brian Kuschak wrote:
>
>> The new power management code is killing the 405GP
>> on-chip ethernet (no interrupts, no phy
>> communications, no packets).
>>
>> If I comment out the body of ppc4xx_pm_init() in
>> ppc4xx_pm.c, ethernet works again.
>>
>> I'm using the 2.4.19 kernel from
>> bk://ppc.bkbits.net/linuxppc_2_4_devel (CS 1.1114).
>>
>> Armin, any comments?
>>
>> Regards,
>> Brian Kuschak
>
>
> Brian,
>
> That would be a bad thing.  I will double check but I think that might
> have been corrected in a later version.  Try pulling a later BK tree.
>
> Armin
>
>


Brian,

I justed tried the latest BK and it worked fine

armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
