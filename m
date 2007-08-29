Return-Path: <fvoegel@carangul.com>
Received: from asgard.akp-net.com (carangul.com [83.149.88.131])
	by ozlabs.org (Postfix) with ESMTP id 0AE51DDDF9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Aug 2007 08:04:46 +1000 (EST)
Received: from port-87-234-84-145.dynamic.qsc.de ([87.234.84.145] helo=lumpi.x)
	by asgard.akp-net.com with esmtpa (Exim 4.62)
	(envelope-from <fvoegel@carangul.com>) id 1IQVeU-0005nR-0P
	for linuxppc-embedded@ozlabs.org; Thu, 30 Aug 2007 00:04:42 +0200
Date: Thu, 30 Aug 2007 01:07:52 +0200
From: "Florian A. Voegel" <fvoegel@carangul.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Network is blocked till ping is issued
Message-Id: <20070830010752.0ca3d309.fvoegel@carangul.com>
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8EA18695@aquib01a>
References: <F1F6EC0C8B75034F9E3A79FC85122E8EA18695@aquib01a>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Antonio,

sounds to me like it could be a classical ARP problem. Have you checked the ARP cache on the non-Linux machine?

On Wed, 29 Aug 2007 19:27:19 +0200
"DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it> wrote:

> I have two hosts 100.1.0.1 (NotLinux) and 100.1.0.2 (linux-2.6.19.2) on
> a vlan.
> On the linux box the vlan interface is created with vconfig and is
> attached to a Virtual PHY (fixed PHY).
> When Linux box starts up, NotLinux wants to setup a TCP connection with
> "Linux box" and sends a SYN packet receiving no answer from "Linux box".
> If from the console of "Linux box" I issue a ping to NotLinux then,
> after a while, the linux box starts responding to Windows.
> 
> Bye,
> Antonio.
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
