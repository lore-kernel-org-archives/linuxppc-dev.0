Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Message-ID: <3B5C6C65.1EBB8B82@mvista.com>
Date: Mon, 23 Jul 2001 14:26:45 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Adam Wozniak <adam.wozniak@comdev.cc>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: fcc_enet Phy detection
References: <3B5708DD.E0788B8B@comdev.cc> <3B571A6A.AFAE4844@comdev.cc>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Adam Wozniak wrote:
>
> Is this normal?

No. I seems your hardware pin configuration to the PHY doesn't
match the driver configuration, or the PHY configuration doesn't
match the hub at the other end.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
