Date: Mon, 8 Apr 2002 11:53:14 -0700
From: Matt Porter <mporter@mvista.com>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_GENERIC_PPC32
Message-ID: <20020408115314.B1048@home.com>
References: <0204081818.AA21305@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0204081818.AA21305@ivan.Harhan.ORG>; from msokolov@ivan.Harhan.ORG on Mon, Apr 08, 2002 at 11:18:43AM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Apr 08, 2002 at 11:18:43AM -0700, Michael Sokolov wrote:
> Of course that fucker, then software eng. manager, now director of engineering
> Art Webb, wanted PeeMON on it no matter how stupid. I obstructed them as much
> as I could by not making a zImage for the Adirondack and telling them that it
> couldn't be done and that one had to boot vmlinux directly on Adirondack. But
> the fuckers did manage to put their PeeMON on Adirondack, of course stealing
> all the very complex board init code from StarMON. They actually made it load
> the vmlinux ELF image and pass it a bi_recs list. But the only info they put in
> there was the memory size. No way to set the command line, select the root
> device, or boot with an initrd. So it's basically unusable. But the fuckers
> didn't care if they make a usable system or not, all they cared was that it
> says "PMON" on it, whether it works or not. No wonder they've recently had two
> big customer projects canceled from what I've heard, with that attitude.

Michael, don't hold back.  Tell us how you really feel.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
