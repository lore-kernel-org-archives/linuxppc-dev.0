Return-Path: <neko@genesi-usa.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157])
	by ozlabs.org (Postfix) with ESMTP id F2D8ADDE1D
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 07:02:04 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so1637973fga.39
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Sep 2008 14:02:01 -0700 (PDT)
Message-ID: <48D807C5.4070002@genesi-usa.com>
Date: Mon, 22 Sep 2008 16:01:57 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: MPC5200 PCI interrupt routing
References: <200809221556.34353.jbe@pengutronix.de>
In-Reply-To: <200809221556.34353.jbe@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Juergen Beisert wrote:
> Hi,
> $ lspci
> 00:18.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 61)
> 00:18.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 61)
> 00:18.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 63)
> 
> USB driver (endianess???) or oftee or hardware problem?
 >
 > Anyone experience with VIA USB hardware on PowerPc?

The USB driver should work fine, I have an Efika (MPC5200B) with that
exact USB controller and revision and it's just fine and dandy. We also
used to ship Via-based USB cards in the Pegasos Open Desktop Workstation
(using Marvell Discovery II northbridge).

The major difference here would be that PCI tree entries were created
by a real OF implementation so may have reflected some hardware better;
it is dynamically created on boot to a certain point, rather than a fixed
device tree which may contain some "errors". There seems to be a lot less
data in our tree...

I can't vouch for the correctness of your tree, though, or tell you
what might be wrong (looks fine as far as I am concerned, but what
do I know? :)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
