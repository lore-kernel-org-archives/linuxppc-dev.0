Subject: Re: Queries regarding porting Linux on MPC850
To: manav@nimbus.ee.iitm.ernet.in (Manav Mediratta)
Date: Wed, 24 May 2000 11:03:15 +1000 (EST)
Cc: greyham@research.canon.com.au, linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.10.10005232130170.5475-100000@astra.ee.iitm.ernet.in> from "Manav Mediratta" at May 23, 2000 09:50:38 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000524010315.C67323C990@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Manav,

Manav Mediratta writes:
> For my project I need to port Linux to a MPC850 board ( our H/W is still
> at schematic level but we are acquiring a test board from Motorola ).I
> have already setup gcc x86/linux -> ppc/linux cross compiler and compiled
> the mpc8xx-2.2.13 source with it .Now can you give me a few tips as to how
> should I proceed about this job once I get my test board .

Sure. There are a bunch of tips, in the HOWTO at:
    http://members.xoom.com/greyhams/linux/PowerPC-Embedded-HOWTO.html

They include:
    - Consider other options before simply settling on a Motorola board.
    - Pick the off-the-shelf board that's closest to your final hardware.
    - Avoid doing a custom board if possible.
    - Use the kernel from the MontaVista site, rather than old mpc8xx-2.2.13.

That should get you started!

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
