Return-Path: <idefix@fechner.net>
Received: from michelle.lostinspace.de (michelle.lostinspace.de
	[62.146.248.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "michelle.lostinspace.de",
	Issuer "michelle.lostinspace.de" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 66FE067BFF
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  5 Nov 2006 03:58:11 +1100 (EST)
Received: from server.idefix.loc (ppp-82-135-90-10.dynamic.mnet-online.de
	[82.135.90.10]) (authenticated bits=0)
	by michelle.lostinspace.de (8.13.8/8.13.8) with ESMTP id kA4GVKwX071447
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>; Sat, 4 Nov 2006 17:31:26 +0100 (CET)
	(envelope-from idefix@fechner.net)
Received: from idefix by server.idefix.loc with local (Exim 4.63 (FreeBSD))
	(envelope-from <idefix@fechner.net>) id 1GgOQS-000IH5-1X
	for linuxppc-embedded@ozlabs.org; Sat, 04 Nov 2006 17:31:20 +0100
Date: Sat, 4 Nov 2006 17:31:19 +0100
From: Matthias Fechner <idefix@fechner.net>
To: linuxppc-embedded@ozlabs.org
Subject: Has anyone 2.6 kernel with Xenomai and MPC5200 Lite running?
Message-ID: <20061104163119.GC69112@server.idefix.loc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Matthias Fechner <idefix@fechner.net>
Reply-To: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I have here a MPC5200 Lite (IceCube/Freescale Lite 5200) and tried to
get Xenomai running.

If I use the 2.6 kernel from denx the board boots fine but I am not
able to patch the kernel with the adeos patch (adeos-patch is for
kernel 2.6.18) and the kernel from denx is 2.6.19rc4. I checked the
changes and they are to much for me to adapt it.

What I need now is a patch for kernel 2.6.18 to get all the MPC5200
stuff running (priority has the networkchip) or a adeos patch for the
denx kernel 2.6.19-rc4.

Can anyone help me here, please?

Best regards,
Matthias

-- 

"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the universe trying to
produce bigger and better idiots. So far, the universe is winning." --
Rich Cook
