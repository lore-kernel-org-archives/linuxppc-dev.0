Subject: RE: Problems bring up NFS mount on MPC8270 board
From: "Guy M. Streeter" <streeter@redhat.com>
To: Jean-Denis Boyer <jdboyer@m5t.com>
Cc: Joe Birch <jbirch@mangrovesystems.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <AB5AF73EAF23304EA1B932174137CED70E6F16@m5tmail.m5t.com>
References: <AB5AF73EAF23304EA1B932174137CED70E6F16@m5tmail.m5t.com>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1067354748.1032.7.camel@jarjar.hsv.redhat.com>
Mime-Version: 1.0
Date: 28 Oct 2003 09:25:48 -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I haven't looked at the others, but I think the 8280 (G2_LE core, pvr
version 0x8082) should have CAN_NAP and HAS_HIGH_BATS, also.
This is what I'm using on my board.

--Guy

On Tue, 2003-10-28 at 07:49, Jean-Denis Boyer wrote:
> The 8270 has a new core revision (Hip7) which have a new PVR:
>
>   Hip3: 0x0081xxxx
>   Hip4: 0x8081xxxx
>   Hip7: 0x8082xxxx
>
> It is probably not recognized has a 603e core, but a generic PPC (which will not work).
>
> May I suggest the patch in attachement (for 'arch/ppc/kernel/cputable.c'). It will correctly recognize the three cpu revisions, and report the chosen one in '/proc/cpuinfo'.
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
