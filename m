In-Reply-To: <booek6$vvl$1@sea.gmane.org>
References: <7AFDCF4E-FCCB-11D6-8F24-003065F22EAA@mindspring.com> <booek6$vvl$1@sea.gmane.org>
Mime-Version: 1.0 (Apple Message framework v606)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9E3C0610-1418-11D8-9936-00039382032A@mindspring.com>
Cc: linuxppc-dev@lists.linuxppc.org
From: Tim Seufert <tas@mindspring.com>
Subject: Re: pmac_halt() bug
Date: Mon, 10 Nov 2003 23:28:17 -0800
To: Igal Baevsky <igal.baevsky@terayon.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Nov 10, 2003, at 8:33 AM, Igal Baevsky wrote:

> Tim Seufert wrote:
>>
>> In platforms/pmac_setup.c, pmac_halt() is defined as follows:
>>
>> pmac_halt(void)
>> {
>>     pmac_power_off();
>> }

> Tim,
> Is there any way to halt PMAC machine with no powering it off ?
> I will realy appretiate your answer - the problem you mentioned above
> is
> the exact problem I'm dealing with .

Assuming the above is still the implementation of pmac_halt(), there's
no way, short of modifying the kernel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
