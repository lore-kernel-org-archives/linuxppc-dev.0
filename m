MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Problems bring up NFS mount on MPC8270 board
Date: Wed, 29 Oct 2003 12:26:28 -0500
Message-ID: <8529B5552D4EAA4DAEDF49650C64B2B41673E2@tarpon.mangrovesystems.com>
From: "Joe Birch" <jbirch@mangrovesystems.com>
To: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for the tip. That was the problem.
A couple of follow up questions for 82xx Hip7 users:

- How to best take advantage of the additional BATs
- Does PCI behave any differently from MPC8265/66
- Any other Hip7 oddities

Joe

-----Original Message-----
From: Guy M. Streeter [mailto:streeter@redhat.com]
Sent: Tuesday, October 28, 2003 10:26 AM
To: Jean-Denis Boyer
Cc: Joe Birch; linuxppc-embedded
Subject: RE: Problems bring up NFS mount on MPC8270 board


I haven't looked at the others, but I think the 8280 (G2_LE core, pvr version 0x8082) should have CAN_NAP and HAS_HIGH_BATS, also. This is what I'm using on my board.

--Guy

On Tue, 2003-10-28 at 07:49, Jean-Denis Boyer wrote:
> The 8270 has a new core revision (Hip7) which have a new PVR:
>
>   Hip3: 0x0081xxxx
>   Hip4: 0x8081xxxx
>   Hip7: 0x8082xxxx
>
> It is probably not recognized has a 603e core, but a generic PPC
> (which will not work).
>
> May I suggest the patch in attachement (for
> 'arch/ppc/kernel/cputable.c'). It will correctly recognize the three
> cpu revisions, and report the chosen one in '/proc/cpuinfo'.
>
> Regards,
>
> --------------------------------------------
>  Jean-Denis Boyer, Eng.
>  M5T Centre d'Excellence en Télécom Inc.
>  4283 Garlock Street
>  Sherbrooke (Québec)
>  J1L 2C8  CANADA
>  (819)829-3972 x241
> --------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
