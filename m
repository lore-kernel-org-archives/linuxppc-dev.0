Message-ID: <3980313E.4845F699@mpifr-bonn.mpg.de>
Date: Thu, 27 Jul 2000 14:55:26 +0200
From: Albrecht Dre_ <ad@mpifr-bonn.mpg.de>
MIME-Version: 1.0
To: Chmouel Boudjnah <chmouel@mandrakesoft.com>
CC: linux1394-devel@lists.sourceforge.net, linuxppc-dev@lists.linuxppc.org,
        cooker-ppc@linux-mandrake.com
Subject: Re: Problem compiling iee3394 on ppc
References: <m2u2dbzqum.fsf@cassini.us.mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Chmouel Boudjnah wrote:
> I have a problem to compile iee3394 the last cvs snapshot on ppc, here
> is the output  :
[error messages snipped]

insert the line

#include <linux/mm.h>

into ieee1394_types.h.

Albrecht.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
