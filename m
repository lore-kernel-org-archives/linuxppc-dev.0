Message-ID: <3B02D1F2.3195B20@mvista.com>
Date: Wed, 16 May 2001 15:16:02 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Jim Duey <jduey@ccc-dcs.com>
Cc: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Kernel differences
References: <3B02A968.4050109@ccc-dcs.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jim Duey wrote:

> ...Can somebody tell me why?

Different driver that actually handles multiple packets.  I just
found out about it yesterday and I'll include the patch in the
FSM Labs source trees.

	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
