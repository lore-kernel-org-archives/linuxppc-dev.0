Message-Id: <200008071514.LAA23286@mal-ach.watson.ibm.com>
To: Gabriel Paubert <paubert@iram.es>
cc: Takashi Oe <toe@unlserve.unl.edu>, Benjamin Herrenschmidt <bh40@calva.net>,
        Martin Costabel <costabel@wanadoo.fr>, linuxppc-dev@lists.linuxppc.org,
        Iain Sandoe <iain@sandoe.co.uk>
Subject: Re: rtc again... 
In-Reply-To: Message from Gabriel Paubert <paubert@iram.es>
   of "Mon, 07 Aug 2000 13:51:32 +0200." <Pine.HPX.4.10.10008071127140.9070-100000@gra-ux1.iram.es>
Date: Mon, 07 Aug 2000 11:14:36 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Not all processors of an SMP complex are started at power-up and
the call to start secodary processors may perform a reset, so I don't
think that one can guarantee that the TB's are synchronized.  Maybe it all
just works, but it does not seem like a requirement of any SMP system
design.

David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
