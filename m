Message-Id: <200003101558.KAA23082@mal-ach.watson.ibm.com>
To: Gabriel Paubert <paubert@iram.es>
cc: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Sean Harding <sharding@dogcow.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: compiler optimization? something else?
In-Reply-To: Message from Gabriel Paubert <paubert@iram.es>
   of "Fri, 10 Mar 2000 10:18:36 +0100." <Pine.HPX.4.10.10003100954580.22162-100000@gra-ux1.iram.es>
Date: Fri, 10 Mar 2000 10:58:52 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Gabriel Paubert writes:

Gabriel> If you don't have a 601 -fgfxopt might also help since it will generate
Gabriel> fsel instructions for min/max/conditional moves. fsel is unfortunately not
Gabriel> implemented on 601 so you can't set gfxopt for distributions.

	Using the appropriate -mcpu=XXX option (e.g., -mcpu=604) sets
-fgfxopt accordingly.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
