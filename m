Date: Thu, 10 May 2001 03:50:57 -0700
From: Matt Porter <mporter@mvista.com>
To: mschmid@ascona.de
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Is CONFIG_8xx the right setting for MPC8240
Message-ID: <20010510035057.B7488@cx258813-a.chnd1.az.home.com>
References: <OF6B040367.6AA70D4B-ONC1256A48.003D8A75@ascona.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF6B040367.6AA70D4B-ONC1256A48.003D8A75@ascona.de>; from mschmid@ascona.de on Thu, May 10, 2001 at 12:23:09PM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, May 10, 2001 at 12:23:09PM +0100, mschmid@ascona.de wrote:
>
> Hello,
>
> i try to get linux running on a board with a MPC8240 CPU (own board
> design).
> In the file mm/init.c there is comment that the 8xx CPUs has no BATs, but
> the MPC8240 has BATs and i want to use them.
> Is it wrong to select CONFIG_8xx for a MPC8240 CPU ?

Absolutely.  The 8240 is a 603e + MPC107-like bridge.  The
6xx/7xx/74xx/82xx choice is the correct platform option.

> I know that the sandpoint board or one of them also uses a MPC8240 but i

An 8240 is one of many PPMC options on the Sandpoint, the F1 port has an
8240 as well.

--
Matt Porter
Montavista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
