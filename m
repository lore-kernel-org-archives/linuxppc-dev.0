Date: Thu, 14 Dec 2000 11:03:28 +1100
From: Graham Stoney <greyham@research.canon.com.au>
To: Nils Hagge <Nils.Hagge@stud.uni-hannover.de>
Cc: Jari Nguyen Trung Thanh <jari.nguyen@serialsystem.com.sg>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel panic: No init found.
Message-ID: <20001214110328.A8430@brixi.research.canon.com.au>
References: <006c01c0650f$73b65d60$1e894b82@pc30> <976717249.3a3785c2030de@mail.serialsystem.com.sg> <009201c06519$e83418d0$1e894b82@pc30>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <009201c06519$e83418d0$1e894b82@pc30>; from Nils.Hagge@stud.uni-hannover.de on Wed, Dec 13, 2000 at 04:32:30PM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Dec 13, 2000 at 04:32:30PM +0100, Nils Hagge wrote:
> "No such file or directory".
> And this is definitely not true. The files do all exist and are readable and
> executable for all (u-g-o).

The files exist, but I'll bet that one or more of the shared libraries they
use don't.  Try execing /bin/sash (which is statically linked) instead.  Once
you get the prompt, do an:
    # ldd /bin/bash

and check to see that the libraries it's looking for are really there.
That link from /opt/hardhat/devkit/ppc/8xx/powerpc-hardhat-linux to / on the
target is usually the obscure problem when using the stuff from MV.  Dunno
what they were thinking...

Regards,
Graham
--
Graham Stoney
Assistant Technology Manager
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
