Message-ID: <383A3610.BF976EDF@netx4.com>
Date: Tue, 23 Nov 1999 01:37:04 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Cort Dougan <cort@fsmlabs.com>
CC: Christian Zankel <chris@mvista.com>, linuxppc-devel@lists.linuxppc.org,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: bootloader & head.S weirdness & restructuring
References: <19991122120429.031138@mailhost.mipsys.com> <19991122143732.B12973@hq.fsmlabs.com> <3839CF18.5D600DE@mvista.com> <19991122165535.A13360@hq.fsmlabs.com> <383A0AA4.1E4227DC@mvista.com> <19991122204001.A14117@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Cort Dougan wrote:

> Yes, I do walk along that path quite often :)

> } head.S. (Try to walk along the 'path' of the 8xx implementation).


OK, I am a little clueless at this hour.  As it appears you are
making fun of the way I wrote that code, perhaps you should
provide a suggestion.  I have more, the 82xx looks just like
that :-)......I am off to look at the m68k tree......


> } I thought that Dan Mallek is working on the 82xx port.


Yes, I am.  Although it is not really 82xx.  The 8240 is a 603
with a diluted MPC106 without OF.  When attached to the Sandpoint,
it looks somewhat like the Gemini port.  The 8260 is a 603 with
a hot rod CPM, so it looks more like the current 8xx port.
Both of these use the "board information" structure in place of
the OF residual like I did on the 8xx.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
