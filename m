Subject: Re: [PATCH] tas3004_tables.c off-by-one
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20031220175850.416fb0ec.colin@colino.net>
References: <20031220175850.416fb0ec.colin@colino.net>
Content-Type: text/plain
Message-Id: <1071962774.8935.23.camel@gaston>
Mime-Version: 1.0
Date: Sun, 21 Dec 2003 10:26:14 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2003-12-21 at 03:58, Colin Leroy wrote:
> Hi,
>
> I noticed that when pushed to the upper limits, the mixer channels on my
> ibook G4 just went silent (tested with master, bass, treble).
>
> I found out this was due to too short (by one item) arrays in
> tas3004_tables.c. This patch fixes it. I just copied over the last entry
> of each array.

Interesting, my understanding is that those values were taken
from Darwin ;) I'll look at this too along with your fan stuff
and merge, thanks.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
