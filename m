Message-ID: <4014FF65.3060608@devcom.cz>
Date: Mon, 26 Jan 2004 12:52:05 +0100
From: Jan Damborsky <jan.damborsky@devcom.cz>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>, linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC823E SMC/I2C/SPI micropatch
References: <20040126113201.DBE4CC108D@atlas.denx.de>
In-Reply-To: <20040126113201.DBE4CC108D@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Wolfgang Denk wrote:
> In message <4014EC18.2000303@devcom.cz> you wrote:
>
>>>>- it is determined for 850 and 823E processors (I hope).
>>>
>>>Wrong.
>>
>>But I really do not uderstand, why there is following
>>sentence in micropatch_850.c file:
>>   The patch applicable to the 850 and 823E processors.
>>And in micropatch_8xx.c:
>>   The patch applicable to all 8xx family except 850 and 823E.
>>I think it is rather misleading, is'nt it ?
>
>
> Yes, it is. Sorry about this. Seems we forgot to update this  comment
> in  the linuxppc_2_4_devel tree (it was fixed in the linux-2.4 tree).
> Fixed now - thanks for pointing out.
>
I thank you for spending your time to persuade me:-)

                                   Sincerely, Jan Damborsky


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
