Date: Thu, 18 Jan 2001 09:50:47 -0700
From: Matt Porter <mporter@mvista.com>
To: Tom Shaver <tom_shaver@psilongbeach.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Booting MCP750 stand alone
Message-ID: <20010118095047.A4838@cx258813-a.chnd1.az.home.com>
References: <3A5DF3CB.BDDCB756@mvista.com> <NCBBJBFMKKFOJFGDOKNBMEDLEJAA.tom_shaver@psilongbeach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <NCBBJBFMKKFOJFGDOKNBMEDLEJAA.tom_shaver@psilongbeach.com>; from tom_shaver@psilongbeach.com on Thu, Jan 18, 2001 at 01:35:20PM -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jan 18, 2001 at 01:35:20PM -0600, Tom Shaver wrote:
>
> Is it possible to boot MVista Linux on a Motorola MCP750 without a
> bootp/tftp server? ie, off of the on board flash, or possibly a compact
> flash card?

Of course, otherwise how would you deploy an MCP750 system? :)

Booting out of the onboard flash is mentioned in the README, you
need to use the BugBoot utility.

IDE is supported so the device in the onboard CF socket will show
up as hda.  Make a type 41 PReP partition on there, dd a kernel
directly into the partition.  Reboot and do a 'pboot 14' at the
PPCBUG prompt.

Oh yes, make sure you populate an initrd or CF partition with the
HHL filesystem to root off of.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
