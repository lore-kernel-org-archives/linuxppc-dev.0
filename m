Date: Thu, 19 Jun 2003 09:13:27 -0500
From: Chris Zimman <chris@cryptoapps.com>
To: Christophe.LINDHEIMER@fr.thalesgroup.com
Cc: zjzhou@newrocktech.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: [Linux] Problem with booting Linux
Message-ID: <20030619141327.GB16069@dingdong.cryptoapps.com>
Reply-To: Chris Zimman <chris@cryptoapps.com>
References: <D96E2AFA0DF3D211B13900902745494805E22C87@helios.gnv.tcc.thomson-csf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D96E2AFA0DF3D211B13900902745494805E22C87@helios.gnv.tcc.thomson-csf.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jun 19, 2003 at 12:44:31PM +0200, Christophe.LINDHEIMER@fr.thalesgroup.com wrote:

> In Bdi, if I make
> 	reset run
> 	go
> Then in Uboot
> 	bootm 0x43000000
> Linux hangs when trying to start init.

What does the board do without the BDI attached?  More interesting yet,
have you stopped the kernel to see where it's hung?

--Chris

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
