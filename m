Date: Mon, 24 Nov 2003 10:12:05 -0600 (CST)
From: vinai <4_usenet@yahoo.com>
To: "LinuxPPC Developers' List" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Lacie FireWire disk howto ?
In-Reply-To: <20031124101629.GA1091@ipnpcu9.acq.ami>
Message-ID: <Pine.LNX.4.44.0311241009030.259-100000@kaiso.biophysics.mcw.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


If you are using a kernel newer than about 2.4.16-18, get the
rescan-scsi-bus.sh script and run it after adding and removing
firewire devices.   "insmod" and "modprobe" of the individual
firewire modules no longer work.

cheers

--
Vinai

To get my real e-mail address, replace "4" with "for" in the above address


On Mon, 24 Nov 2003, xavier grave wrote:

>
> Hi,
>
> I have a Lacie Firewire disk I try to run under a
> Linux ipnnarval 2.4.23-pre5-ben0
>
> after a modprobe of sbp2 ohci1394 ieee1394
> I get the following messages :
> ohci1394: $Rev: 1010 $ Ben Collins <bcollins@debian.org>
> ohci1394_0: Unexpected PCI resource length of 1000!
> ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[40]  MMIO=[f5000000-f50007ff]
> Max Packet=[2048]
> ieee1394: ConfigROM quadlet transaction error for node 0-00:1023
> ieee1394: Host added: ID:BUS[0-01:1023]  GUID[000393fffebcd94a]
> sbp2: $Rev: 1010 $ Ben Collins <bcollins@debian.org>
> ieee1394: Node changed: 0-01:1023 -> 0-00:1023
> ieee1394: Node 0-01:1023 has non-standard ROM format (0 quads), cannot
> parse
> ieee1394: The root node is not cycle master capable; selecting a new
> root node and resetting...
> ieee1394: Node 0-00:1023 has non-standard ROM format (0 quads), cannot
> parse
> ieee1394: Node changed: 0-00:1023 -> 0-01:1023
>
> What I have done wrong ?
>
> thanks in advance, xavier
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
