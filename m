Message-Id: <200003111944.OAA24668@mal-ach.watson.ibm.com>
To: Giuliano Pochini <pochini@denise.shiny.it>
cc: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Sean Harding <sharding@dogcow.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: compiler optimization? something else?
In-Reply-To: Message from Giuliano Pochini <pochini@denise.shiny.it>
   of "Sat, 11 Mar 2000 17:32:31 EST." <38CAC97F.4F45265A@denise.shiny.it>
Date: Sat, 11 Mar 2000 14:44:34 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Fused multiply-add always is used on POWER/PowerPC unless the user
specifically request that it not be used.  -ffast-math does not affect
it.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
