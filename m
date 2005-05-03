Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 49B8C679F9
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 May 2005 16:16:59 +1000 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DSqbr-0005wp-8A
	for linuxppc-embedded@ozlabs.org; Tue, 03 May 2005 08:10:19 +0200
Received: from s0106000024c002e0.ss.shawcable.net ([70.64.46.12])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 03 May 2005 08:10:19 +0200
Received: from jbi130 by s0106000024c002e0.ss.shawcable.net with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 03 May 2005 08:10:19 +0200
To: linuxppc-embedded@ozlabs.org
From: jbi130@yahoo.com
Date: 03 May 2005 00:15:14 -0600
Message-ID: <87sm14n8ct.fsf@nimrod.unx.ca>
References: <4275F2BB.9050100@radionor.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@sea.gmane.org>
Subject: Re: Ethernet bridging on MPC8248
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ole Andreas Torvmark <ole.torvmark@radionor.no> writes:

> ifconfig eth0 0.0.0.0
> ifconfig eth1 0.0.0.0
> brctl addbr br0
> brctl addif br0 eth0
> brctl addif br0 eth1
> ifconfig br0 192.168.0.222 netmask 255.255.255.0
> 
> If I connect a machine to port 0 (eth0) then I can ping the bridge
> from that machine,
> 
> If I connect a machine to port 1 (eth1) I cannot ping the bridge.
> If I connect machines to both ports, I cannot ping one machine from
> the other, the only thing i can successfully ping is from port 0 to
> bridge and from bridge to port 0
> 
> Is this a known problem with the FCC ENET driver or does it support
> bridging fully ?

Have you made sure that eth0 and eth1 are 'up'?  eg) ifconfig eth0 up.
I'm not sure, but br0 may need to be up as well.
