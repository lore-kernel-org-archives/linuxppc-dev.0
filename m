Message-ID: <3F01C3D7.7030905@mvista.com>
Date: Tue, 01 Jul 2003 10:24:39 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: nbasker@india.tejasnetworks.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: problems in SCC-UART in mpc860
References: <1057070760.3f019ea838280@pop-mail.india.tejasnetworks.com>
In-Reply-To: <1057070760.3f019ea838280@pop-mail.india.tejasnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


What's the PVR of your 860?

Mark
--

nbasker@india.tejasnetworks.com wrote:

>Hi:
>
>I am trying to use a SCC configured in UART to communicate with a intel
>pc via modem. The configuration is simple and shown below
>
>target --- modem -------phoneline---- modem----i386pc
>
>target configuration:
>1. mpc860T custom board
>2. scc2 configured in uart
>3. linux-2-2-14 from montavista
>4. patched 8xx_io/uart.c from 2.2.4 kernel from Denks
>5. using mgetty/pppd to program modem and start pppd.
>
>host configuration:
>1. i368pc running 2.2.14-12 redhat kernel
>2. using pppd/chat to dialup to target modem.
>
>In this setup if use PCSO to enable RTS, CTS and CD along with
>crtscts option in pppd nothing works. If I disable PCSO and use
>nocrtscts option in pppd, LCP connection goes through but IPCP
>exchange at target fails (it never sends ConfigAck packet towards host).
>
>I am able to get the setup working using null modem cable enabling
>RTS/CTS/CD via PCSO register as well as pppd options.
>
>Since I am able to get SCC2/UART working with nullmodem, but not
>with actual modem, should I suspect hardware signal connectivity as
>a problem source?. I suspected the uart driver and went through
>all the register settings described in Section 23.21 of 860T user
>manual and everything seems to be fine.
>
>Any hint or help on this issue will be greatly appreciated.
>
>Thanks for your time,
>Nicholas.
>
>-------------------------------------------------
>This mail sent through Tejasnetworks Webclient
>
>
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
