Message-ID: <D73A25AA6E54D511AD74009027B1110F3C0901@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'t.vanremortel@ha.be'" <t.vanremortel@ha.be>
Cc: PPC Mailinglist <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: EP405 network interface
Date: Wed, 2 Jul 2003 10:29:40 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You need to look at the board's user manual.  There is a section called
"Board Control and Status Registers"

-----Original Message-----
From: Toni Van Remortel [mailto:t.vanremortel@ha.be]
Sent: Wednesday, July 02, 2003 10:25 AM
To: Steven Blakeslee
Cc: PPC Mailinglist
Subject: RE: EP405 network interface


How and where?

I found that the PHY address in the manual is 0b00000 and in the code
PPC405_PCI_PHY_MEM_BASE is set to 0x80000000.


Op do 26-06-2003, om 20:39 schreef Steven Blakeslee:
> Did you enable the phy in the Board Control Status Register?
>
> -----Original Message-----
> From: Toni Van Remortel [mailto:t.vanremortel@ha.be]
> Sent: Thursday, June 26, 2003 10:01 AM
> To: PPC Mailinglist
> Subject: EP405 network interface
>
>
>
> Hi all,
>
> I cannot get the NIC working on my EP405. I used the ep405_config from
> the linuxppc_2_4_devel tree.
>
> This is a part of the output:
>
> ...
> loop: loaded (max 8 devices)
> eth0: No PHY device found.
> removing net dev
> ...
>
> So it seems that the kernel doesn't find the NIC (but it is there, and
> working, ep-bootloader can use it to download the image).
>
> Anybody an idea?
>
> I already checked the NIC support, and the onboard-IBM NIC support is
> enabled.
>
> Regards,
> --
>                            Toni Van Remortel
>               Wetenschappelijk Medewerker - D-science lab
>                  Tel: 03 205 61 72 - Fax: 03 205 61 95
>                       E-mail: t.vanremortel@ha.be
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
