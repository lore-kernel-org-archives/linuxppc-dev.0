To: "dony" <dony.he@huawei.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Which board use 8260 CPU? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 26 Feb 2001 19:40:08 +0800."
             <000901c09fe8$def06760$8021690a@huawei.com>
Date: Mon, 26 Feb 2001 21:04:59 +0100
Message-Id: <20010226200504.00F03287EA@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <000901c09fe8$def06760$8021690a@huawei.com> you wrote:
>
>     I just downloaded ppcboot.tar.gz files.
>    Since my custom board use 8260, I want to find a board  using 8260 from ppcboot/board as a example.  I know "cogent"  board supports 8260, but it seems to be a little complex for me.
> Are there other boards using  8260 CPU which can meet the following requirements:

Just check the top  level  Makefile;  it  contains  targets  for  all
standard board configurations, and the definition of the CPU variable
give  you  some hints; there are 3 boards with 82xx CPU at the moment
(some more in the works): sandpoint (8240), hymod (8260)  and  cogent
(8260).

>  1  Initialize CPU core registers , SDRAM, MMU,SIU, CPM
>  2  Initialize Serial Port and Network (SMC , FCC).
> 3  Download kernel from tftp server or load kernel from on-board flash ?

AFAIK, all of them do that.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The software required `Windows 95 or better', so I installed Linux.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
