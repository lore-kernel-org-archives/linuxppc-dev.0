Message-ID: <403D179F.7040101@mvista.com>
Date: Wed, 25 Feb 2004 14:46:07 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Cc: debian-powerpc@lists.debian.org, debian-powerpc@lists.debian.org,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Need testers: G3 @ G4 laptops (powerbooks & ibooks)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


     >/ Are you sure that you can get away with this, passed on how the
    manuals/
     >/ (745x) describe the sequence of flush/invalidating the L2 (and,
    L3) ?/

    Do they describe disabling the L1 at all ?

[Somehow I was removed from the -dev & -embedded list.  I was wondering
why I hadn't seen anything for a while  :)]
[Also, trini prodded me to send this email and I didn't go back and read
the whole thread so this may be a little out of context]

Ben, FYI,

The latest 745x user manual is here:
 http://e-www.motorola.com/files/32bit/doc/ref_manual/MPC7450UM.pdf

Here are some relevant sections:
- 3.4.1.1 (p. 3-32) Enabling and Disabling the Data Cache
- 3.4.1.3 (p. 3-33) Enabling and Disabling the Instruction Cache
- 3.6.3.1.5 (p. 3-55) Flushing of L1, L2, and L3


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
