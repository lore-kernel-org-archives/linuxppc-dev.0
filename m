Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 5490367C2F
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Nov 2006 08:19:09 +1100 (EST)
Date: Sun, 26 Nov 2006 22:19:10 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Rutger Nijlunsing <eludias@dse.nl>
Subject: Re: powerpc.git build error
In-Reply-To: <20061126210535.GA5639@nospam.com>
Message-ID: <Pine.LNX.4.60.0611262218050.8431@poirot.grange>
References: <20061125225807.GA10510@nospam.com>
	<1164523183.10222.1.camel@localhost.localdomain>
	<20061126190609.GA20291@nospam.com>
	<Pine.LNX.4.60.0611262144230.8431@poirot.grange>
	<20061126210535.GA5639@nospam.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 26 Nov 2006, Rutger Nijlunsing wrote:

> It seems suspend-to-ram is working to some extend, or at least
> 'should' work out-of-the-box. When I close the lid and reopen it, it
> resumes 'a little': PCMCIA cards seem to power up again (TX/RX WiFi
> led starts to flash again), but the screen stays dark. I haven't tried
> to debug this yet, since getting WiFi to work

Ah, sure, it IS the pmac - the only one PPC machine having STR in the 
mainline, lucky you:-) ok, good luck to me then:-)

Thanks
Guennadi
---
Guennadi Liakhovetski
