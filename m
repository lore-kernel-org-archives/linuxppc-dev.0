Message-ID: <047301c0d75c$2da00a00$4b00000a@foolio1>
From: "Eli Chen" <eli@routefree.com>
To: "Dan Malek" <dan@mvista.com>
Cc: "Gabriel Paubert" <paubert@iram.es>,
	<brian.kuschak@skystream.com>, <linuxppc-embedded@lists.linuxppc.org>
References: <Pine.HPX.4.10.10105072359470.22253-100000@gra-ux1.iram.es> <3AF72CA8.52163E55@mvista.com> <03a001c0d74e$60022c70$4b00000a@foolio1> <3AF73161.26986237@mvista.com> <040a01c0d754$1bf6d5c0$4b00000a@foolio1> <3AF740C0.F65FBCB8@mvista.com>
Subject: Re: dcache BUG()
Date: Mon, 7 May 2001 18:14:06 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've been running Gabriel's patch for a while now, and I'm still seeing the
"de_put: entry net already free!" messages from running Brian's test
(although seemingly not as often).

I do believe Gabriel is right about clearing the reservation before the rfi,
not in transfer_to_handler.  Perhaps there are other places that returns
from an interrupt?

-eli


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
