To: "Mark A. Greer" <mgreer@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mpc755, sandpoint port and 1Gb of ram
In-reply-to: Your message of "Wed, 02 Jul 2003 10:25:31 PDT."
             <3F03158B.7090706@mvista.com>
Date: Thu, 03 Jul 2003 12:31:52 -0400 (EDT)
Message-Id: <14511.1057249912@mja-pc-linux.dhcp.pit.laurelnetworks.com>
From: "Michael J. Accetta" <mja@laurelnetworks.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark

    Its probably just a personal preference but I think changing the mapping
    and leaving PKMAP_BASE alone is a better way.  Someday I will do that
    for the sandpoint port.

    In short, what you did, assuming you did it properly, should work fine.

Thanks much for the confirmation.  That did seem less risky than
changing the sandpoint I/O mapping without understanding where all the
I/O addresses were expected to be (which I don't).  I would concur,
though, that that approach seems a better someday solution.

I am using the configure process to change PKMAP_BASE.

Mike

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
