Date: Fri, 6 Dec 2002 08:54:19 -0700
From: Matt Porter <porter@cox.net>
To: Pantelis Antoniou <panto@intracom.gr>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Regarding consistent_alloc
Message-ID: <20021206085419.A17918@home.com>
References: <3DF0A39D.2090401@intracom.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3DF0A39D.2090401@intracom.gr>; from panto@intracom.gr on Fri, Dec 06, 2002 at 03:18:21PM +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Dec 06, 2002 at 03:18:21PM +0200, Pantelis Antoniou wrote:
>
> Hi
>
> Can someone tell what is the deal with these functions?
>
> consistent_alloc et. al. are very useful to me now that I'm
> cleaning up my QMC driver. But they are exported.
>
> Is there any reason why they are not exported for use by
> modules?

They are exported in the development trees I use, linuxppc_2_4_devel
and linuxppc-2.5.

> Also they appear to be tied to the PCI bus, a reduntant
> dependancy IMHO.

How so?  consistent_alloc/consistent_free are independent of pci bus.
Use those.  pci_* are, by definition, pci-specific and only exported
on PCI-based systems.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
