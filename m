Reply-To: <jdomogala@acmepacket.com>
From: "Jeff Domogala" <jdomogala@acmepacket.com>
To: "Embedded Linux PPC list" <linuxppc-embedded@lists.linuxppc.org>
Subject: Looking for GT64260 MPSC serial console driver
Date: Tue, 27 Jul 2004 17:27:36 -0400
Message-ID: <NFBBJCNFKLFMBACPKDKCOEMDEDAA.jdomogala@acmepacket.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <015b01c4741d$aca87010$0301a8c0@chuck2>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello folks.

I am looking for a MPSC serial console driver for the Marvell GT-64260.  I
have one from an old 2.4 development tree but it looks like it never made it
into the linuxppc-2.5 tree.  I would also entertain anyone who could point
me in the direction of what needs to be done to port a serial console driver
from a 2.4 kernel to the current 2.6 kernel in the linuxppc-2.5 tree.

Thanks,

Jeff Domogala


-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Mark
Chambers
Sent: Tuesday, July 27, 2004 5:07 PM
To: Robert P. J. Day; Embedded Linux PPC list
Subject: Re: more questions about 8xx microcode patches



Robert,

I know I've never had a need to use a microcode patch.  Maybe a quick
survey - has anybody ever had a need to use two patches at once?  I'm
suspecting you may be putting a lot of effort into something that's rarely
needed.  Also, as Motorola updates their silicon the patches will likely
become less relevant (less likely that new users will need the patches).

Mark Chambers


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
