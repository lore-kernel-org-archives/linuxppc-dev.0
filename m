MIME-Version: 1.0
Message-Id: <39726744.22036@mta6>
Date: Mon, 17 Jul 2000 09:54:12 +0800 (CST)
From: "zzh" <david-1z@263.net>
To: Dan Malek <dan@netx4.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re:Re: Local sdram in 8260 board
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>zzh wrote:
>
>> ...it will get machine check exception
>> at address 0x1000004 which is in the local sdram.When i disable the
>> cache ,it will work.
>
>
>It sounds like something is wrong with your memory controller
>configuration.  The cache enable/disable also affect the type of
>bus cycles that are used to access memory.
Aha, I read the 8260 manual charpter 10 and find it will generate
TEA if core try to burst access local bus address space.Why this restriction?
Maybe this is the reason of Machine Check.
>
>

>	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
