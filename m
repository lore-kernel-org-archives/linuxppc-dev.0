Message-Id: <5.1.0.14.2.20030124113040.02936020@pop.prodigy.net>
Date: Fri, 24 Jan 2003 11:34:00 -0800
To: Chris Zimman <chris@cryptoapps.com>
From: Eugene Surovegin <ebs@innocent.com>
Subject: Re: Status of 440GP support?
Cc: linuxppc-embedded@lists.linuxppc.org, brian.auld@adic.com
In-Reply-To: <20030124183802.GA21151@mail.cryptoapps.com>
References: <995FF289C9D69747A09E42992644595405B23621@penguin.adic.com>
 <995FF289C9D69747A09E42992644595405B23621@penguin.adic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 10:38 AM 1/24/2003, you wrote:
>One way (there may be better ways) is:
>
>cp arch/ppc/configs/ebony_defconfig .config
>make oldconfig


Yes, there is "a better way" :)

make ebony_config
make oldconfig



  Eugene Surovegin <mailto:ebs@innocent.com>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
