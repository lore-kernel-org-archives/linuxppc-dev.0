Subject: Re: How to access another DSP device w/ TAS3001c?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ted <ted@2600.COM>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.NEB.4.44.0307161343520.18512-100000@phalse.2600.com>
References: <Pine.NEB.4.44.0307161343520.18512-100000@phalse.2600.com>
Content-Type: text/plain
Message-Id: <1058428624.507.112.camel@gaston>
Mime-Version: 1.0
Date: 17 Jul 2003 09:57:05 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The PowerBook HW has only one DMA channel to the mixer, so
the mixing must be done in software

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
