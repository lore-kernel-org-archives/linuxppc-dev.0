Date: Tue, 14 May 2002 19:24:48 -0700
From: Matt Porter <mporter@mvista.com>
To: sanjay k k <fren00@rediffmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Does PPC 440 kernel supports P2P bridge
Message-ID: <20020514192448.A6299@home.com>
References: <20020515014447.16612.qmail@webmail2.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020515014447.16612.qmail@webmail2.rediffmail.com>; from fren00@rediffmail.com on Wed, May 15, 2002 at 01:44:47AM -0000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, May 15, 2002 at 01:44:47AM -0000, sanjay k k wrote:
>
> Does PPC 440 kernel supports P2P bridge. I have kernel from
> development tree. It gets hanged when i plugged the P2P card in
> PCI slot.

It should, PCI is no different than on any other Linux/PPC platform.
Where does it hang?  Any kernel output?  If so, please enable
debug in pci_auto.c and drivers/pci/pci.c. If not, please show
early output by enabling early serial debug text or by using
your JTAG debugger.  With a JTAG debugger you can dump
log_buf if you are hanging before console_init.

Regards,
--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
