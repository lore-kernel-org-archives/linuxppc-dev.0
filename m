In-Reply-To: <0B0A39652BB0D411BCCF00508B9512EC106D80BE@tx14exm05.ftw.mot.com>
References: <0B0A39652BB0D411BCCF00508B9512EC106D80BE@tx14exm05.ftw.mot.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <91628297-D9A3-11D8-AE55-000393C30512@freescale.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: ethtool on gianfar ethernet driver on MPC85xx platform
Date: Mon, 19 Jul 2004 11:49:14 -0500
To: Guo Eileen-QEG000 <QEG000@motorola.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I just got back from vacation, and have sent a similar message to
chau.duong@motorola.com:

Hmmm...  Could you tell me what version of the kernel you have?  In
other words, when/where did you get this code?

Have you ifconfig-ed eth0?

I will look into it in the meantime to see if 1.8 works with my kernel.

Andy Fleming

On Jul 14, 2004, at 09:15, Guo Eileen-QEG000 wrote:

>
> All,
>
> I am using the gianfar ethernet driver on MPC8540 platform.
> The gianfar driver itself includes code that supports ethtool
> (gianfar_ethtool.c)
> We downloaded the ethtool.c utility program version 1.8 and tried to
> access
> the ethtool on gianfar driver.  Here is what we received when
> entering the ethtool commands:
>> ethtool -i eth0
> Cannot get driver information:  Operation not supported
>> ethtool -d eth0
> Cannot get driver information:  Operation not supported
>
> Does anyone know how to access the ethtool on the gianfar driver?
>
> thanks,
>
>
> Eileen Guo
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
