Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5BF50DE200
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 00:40:31 +1000 (EST)
Received: from LPSC0173W (lpsc0173w.in2p3.fr [134.158.40.173])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with SMTP id m3IEeQET005413
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 16:40:27 +0200
Message-ID: <04c001c8a162$242e7330$ad289e86@LPSC0173W>
From: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
To: <linuxppc-dev@ozlabs.org>
References: <03fc01c8a072$67280110$ad289e86@LPSC0173W>
	<20080417155609.9061E1D000B0@mail147-sin.bigfish.com>
Subject: Re: Xilinx network trouble (mostly solved)
Date: Fri, 18 Apr 2008 16:40:21 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Rick,

> Which version of xps_ll_temac are you using, and which version of EDK?
Using xps 9.2.02i, build EDK_lm_SP2.3+0

IP version for the TriMode_MAC_GMII (xps_ll_temac) is 1.00.b. EmacLite is 
1.00.a

> Also, do both designs meet timing?
As the software guy here, I have no idea. I've passed the question onto the 
electronics guys...

BUT, you put me on the right tracks: looking at the driver versions I 
started playing with the options you get in the [Configure IP] of the 
Ethernet Mac drivers. I couldn't get any improvement with the LLTEMAC, but 
after I added the buffers to the EmacLite: IT WORKED !

I'm still having trouble mounting an NFS root and ssh'ing into the target, 
but I guess that's another issue...
-- 
Guillaume Dargaud
http://www.gdargaud.net/
