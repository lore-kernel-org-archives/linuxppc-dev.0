Date: Fri, 28 Mar 2003 10:45:01 -0300
Message-Id: <HCGOV1$IHOcMkAllk38XE89wMohNoFOIUP5KcYdl8o7qEw1dC@bol.com.br>
Subject: Re: [OT] bdiGDB connection problems
MIME-Version: 1.0
Content-Type: text/plain;charset="iso-8859-1"
From: "xisto.garcia" <xisto.garcia@bol.com.br>
To: linuxppc-embedded@lists.linuxppc.org
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there!

> Change the BDI-2000 subnet mask to 255.255.255.0. Make sure your
> RedHat 8.0 host also uses same subnet mask. Delete the entry for
> gatweay, it is not needed. BDI does not support ping. However, if you
> can see arp request-replies, all is well. Fix your subnet mask.

Hummm... changing the submask doesn't work... about the gateway, I
did'n't find a way to delete it. Anyway, they are on the same subnet!

I wonder whenever my firmware is broken 8) By the way, does anybody has
a working 1.15 firmware?

Thanks,
Xisto

> >I'm new to bdiGDB and I'm facing some problems with it. I've got a
> >bdiGDB for a 82xx PPC and I've correctly updated its firmware and
> >configured it through the RS232 interface, specifying its IP address,
> >my host IP, bla bla bla. But when I try to communicate through the
> >ethernet, by a telnet section, it doesn't seem to respond at all.
> >
> >Some facts:
> >
> >- Target MPC8260 in a MPC8260ADS board;
> >- RedHat Linux 8.0 as the host;
> >- dump from the bdi200 setup:
> >
> >BDI Type : BDI2000 Rev.C (SN: xxx)
> >Loader   : V1.05
> >Firmware : V1.15 bdiGDB for PPC6xx/PPC7xx
> >Logic    : V1.02 PPC6xx/PPC7xx
> >MAC      : 00-0c-01-xx-xx-xx
> >IP Addr  : 192.168.0.2
> >Subnet   : 255.255.255.255
> >Gateway  : 255.255.255.255
> >Host IP  : 192.168.0.1
> >Config   : mpc820ads.cnf
> >
> >- The 'load mode' was correctly closed;
> >- The ethernet 'link' led is on and the 'rx' led blinks as packets
> >  ares sent on the net;
> >- The bdi doesn't even answer my pings!
> >- Sniffering the net, I've seen several ARP request and replies,
> >  exchanged by bdi->host and host->bdi.
> >
> >Some questions:
> >
> >- Do I need to have my target conected to bdi in order to
> >  stabilish the telnet connection?
> >- What about the tftp server, does it have to be running at
> >  this point?
> >- What services are provided by the bdi? Telnet on TCP port 23?
> >  ICMP also? And what about the debugger, does it listen to
> >  port 2001?
> >- How can I get it running?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
