Date: Wed, 8 Nov 2000 19:37:09 +0100 (MET)
From: Tobias Otto-Adamczak <tobias.otto-adamczak@e-technik.tu-chemnitz.de>
To: clark@esteem.com
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: SPI driver?
In-Reply-To: <5.0.0.25.1.20001108090609.00a4ead0@pop.esteem.com>
Message-ID: <Pine.LNX.4.21.0011081931320.13081-100000@pandora.hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I was wondering if anbody has a working SPI driver yet.

I have no ready-to-use driver but a few functions (init, transfer,
disable) that I use successfully with my MBX.

> I also noticed it relied on CPM_IIC micro code patch,

My code works with or witout the patch; MBX uses SCC1 for Ethernet.

Ciao - Tobias


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
