In-Reply-To: <AB5AF73EAF23304EA1B932174137CED7030447@m5tmail.m5t.com>
References: <AB5AF73EAF23304EA1B932174137CED7030447@m5tmail.m5t.com>
Mime-Version: 1.0 (Apple Message framework v606)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <3B6A39C6-2A1A-11D8-B259-003065E2BB06@aimsys.nl>
Cc: <linuxppc-embedded@lists.linuxppc.org>,
	"Ricardo Scop" <scop@digitel.com.br>
From: Jaap-Jan Boor <jjboor@aimsys.nl>
Subject: Re: 8270 performance
Date: Tue, 9 Dec 2003 08:35:16 +0100
To: "Jean-Denis Boyer" <jdboyer@m5t.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 8-dec-03, at 22:11, Jean-Denis Boyer wrote:

>
> Ricardo,
> Jaap-Jan,
>
>>> I would expect the bogomips number
>>> to be somewhere near the core clock
>>> (like 8xx).
>>
>> Well, I think the numbers are pretty fair, assuming that the
>> bogomips number
>> reflect a certain amount of external memory accesses at 66
>> MHz external bus
>> clock.
>
> It has more to do with pipelining!
> Hopefully, there ain't any memory access during calibration...
> (except, of course, when the instruction cache is disabled!)
>
> I didn't look at the documentation, but the execution of a branch
> probably occurs later in the pipeline of a 8260 than for the 860. It
> probably looses one more cycle. The calibration relies on the
> execution speed of function __delay (arch/ppc/kernel/misc.S), which
> loops on a branch instruction 'bdnz'.
>
> Fortunately, the number of bogomips will increase linearly with the
> core clock.
> (These are approximations)
>
> For 8260:
>  200MHz => 66M bdnz per second => 133BogoMips
>  266    => 88M                 => 176
>  400    => 133M                => 266
>
> For 860:
>  50MHz => 25M bdnz per second => 50BogoMips

Ok, that's a nice explanation, thanks!

Jaap-Jan

>
>
> Regards,
> --------------------------------------------
>  Jean-Denis Boyer, Eng.
>  M5T Centre d'Excellence en Télécoms Inc.
>  4283 Garlock Street
>  Sherbrooke (Québec)
>  J1L 2C8  CANADA
>  (819)829-3972 x241
> --------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
