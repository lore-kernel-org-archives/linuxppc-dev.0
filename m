Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3D6578FD.6020105@redswitch.com>
Date: Thu, 22 Aug 2002 16:51:25 -0700
From: "Xiaogeng (Shawn) Jin" <xjin@redswitch.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: fast ethernet LXT972A support
References: <20020822233413.E2CBD11822@denx.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>distribution from DENX. But the comments in fec.c say "includes support
>>for following PHYs: QS6612, LXT970, LXT971/2". Does it mean that LXT972
Well, the first several lines of comments says that. ;)

> Ummm.... you must be looking in the wrong place; our  kernel  version
> supports  AMD79C874, LXT970, LXT971, QS6612, DP83843, and DP83846A on
> MPC8xx processors, and AMD79C873, LXT970, LXT971, QS6612  on  MPC8260

Well, the version I got is linux-2.4.4-08-09. And I'm sure there are no
DP83843 and DP83846A support. So you must have made progress in
supporting new PHYs. :) The file I'm looking at is arch/ppc/8xx_io/fec.c.

- Shawn.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
