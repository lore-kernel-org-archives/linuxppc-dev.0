Date: Wed, 09 Jul 2003 17:44:56 +1200
From: Dmytro Bablinyuk <dmytro.bablinyuk@tait.co.nz>
Subject: Re: Problem with starting up 2.4.21 kernel
In-reply-to: <20030709050619.19722.qmail@web9705.mail.yahoo.com>
To: linuxppc mail list <linuxppc-embedded@lists.linuxppc.org>
Message-id: <3F0BABD8.5010703@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
References: <20030709050619.19722.qmail@web9705.mail.yahoo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>  1. Have you configured correctly the timers?

I tried to pass in Hz and in MHz by playing with clocks_in_mhz
environment variable

> 2. Have you correctly configured the serial interface
> (where you have your console)? SCC,SMC..etc.

I could not find in my .config where I can define a SMC1 to use for UART
but I have:
#
# MPC8xx CPM Options
#
# CONFIG_SCC_ENET is not set
CONFIG_FEC_ENET=y
# CONFIG_USE_MDIO is not set
CONFIG_ENET_BIG_BUFFERS=y
# CONFIG_SMC2_UART is not set
# CONFIG_USE_SCC_IO is not set
CONFIG_8xx_COPYBACK=y
CONFIG_8xx_CPU6=y
CONFIG_UCODE_PATCH=y

> And, could you see inside the System.map in what
> function does your kernel locks?

It's a m8xx_cpm_reset function.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
