MIME-Version: 1.0
Message-Id: <396EE4BF.15401@mta6>
Date: Fri, 14 Jul 2000 18:00:31 +0800 (CST)
From: "zzh" <david-1z@263.net>
To: "Andrew W. Reynolds" <awreynolds@alum.rit.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re:Re: Local sdram in 8260 board
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>This could be the setup of the SDRAM control word. When the cache is enabled it
>begins bursting data from the SDRAM. When the SDRAM control word is not set to
>burst 32 bytes it will cause the memory exception.
>
>Dan Malek wrote:
>
I guess it maybe error in local sdram memc init.I follow the code provided by motorola. After machine check,i check location in
IMM related to local sdram error reporting and cannot find some
hint.And SRR1 does not provide any hint too.Do you think the
init value i program the memc and register values in machine check
will help?
>> zzh wrote:
>>
>> > ...it will get machine check exception
>> > at address 0x1000004 which is in the local sdram.When i disable the
>> > cache ,it will work.
>>
>> It sounds like something is wrong with your memory controller
>> configuration.  The cache enable/disable also affect the type of
>> bus cycles that are used to access memory.
>>
>>         -- Dan
>>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
