Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id 7DFC2DDDFD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Aug 2007 04:34:06 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Re: Network is blocked till ping is issued(update)
Date: Wed, 29 Aug 2007 20:34:03 +0200
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8EA18698@aquib01a>
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8EA18695@aquib01a>
From: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I have two hosts 100.1.0.1 (NotLinux) and 100.1.0.2 (linux-2.6.19.2 on
MPC880) on
a vlan.
On the linux box the vlan interface is created with vconfig on the eth1
and is
attached to a Virtual PHY (fixed PHY).
When Linux box starts up, NotLinux wants to setup a TCP connection with
"Linux box" and sends a SYN packet receiving no answer from "Linux box".
If from the console of "Linux box" I issue a ping to NotLinux then,
after a while, the linux box starts responding to Windows.

Bye,
Antonio.
