Message-ID: <4014EC18.2000303@devcom.cz>
Date: Mon, 26 Jan 2004 11:29:44 +0100
From: Jan Damborsky <jan.damborsky@devcom.cz>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>, linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC823E SMC/I2C/SPI micropatch
References: <20040126093345.5EC57C108D@atlas.denx.de>
In-Reply-To: <20040126093345.5EC57C108D@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Wolfgang Denk wrote:
> In message <4014DD1D.8070704@devcom.cz> you wrote:
>
>>I think I have selected the __correct__ one.
>>Situated in ./arch/ppc/8xx_io/micropatch_850.c file.
>
>
> No!!! The micropatch_850.c is ONLY for MPC850, and NOT for MPC823(E).
OK, so I will try and use micropatch_8xx.c instead.

>
>
>>- it is determined for 850 and 823E processors (I hope).
>
>
> Wrong.
But I really do not uderstand, why there is following
sentence in micropatch_850.c file:
   The patch applicable to the 850 and 823E processors.
And in micropatch_8xx.c:
   The patch applicable to all 8xx family except 850 and 823E.
I think it is rather misleading, is'nt it ?

	Sincerely, Jan Damborsky


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
