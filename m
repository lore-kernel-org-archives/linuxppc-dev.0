Date: Thu, 22 Nov 2001 08:18:26 -0700 (MST)
From: Derrik Pates <dpates@dsdk12.net>
To: benh@kernel.crashing.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Again with the firewire
In-Reply-To: <20011122110036.9302@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.40.0111220815430.14868-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 22 Nov 2001 benh@kernel.crashing.org wrote:

> Well, there is no code to handle power management in the driver, and
> the controller do get powered down, so... If it works, maybe you are
> just lucky ;)

Doh. Oops on me. Brought the iBook up from sleep this morning, and ran
GScanBus to get the FireWire controller tested - hard freeze. Guess I
spoke too soon. :) But hey, it's serious progress already that FireWire
works at all, so I'm not complaining or anything...

Derrik Pates      |   Sysadmin, Douglas School   |    #linuxOS on EFnet
dpates@dsdk12.net |     District (dsdk12.net)    |    #linuxOS on OPN


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
