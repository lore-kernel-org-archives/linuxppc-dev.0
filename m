Return-Path: <idefix@fechner.net>
Received: from michelle.lostinspace.de (michelle.lostinspace.de
	[62.146.248.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "michelle.lostinspace.de",
	Issuer "michelle.lostinspace.de" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 06157DDF08
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Mar 2007 05:16:35 +1100 (EST)
Received: from server.idefix.lan (cl-70.muc-02.de.sixxs.net
	[IPv6:2001:a60:f000:45::2]) (authenticated bits=0)
	by michelle.lostinspace.de (8.13.8/8.13.8) with ESMTP id l2JIGNlx032284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Mar 2007 19:16:28 +0100 (CET)
	(envelope-from idefix@fechner.net)
Received: from idefix by server.idefix.lan with local (Exim 4.66 (FreeBSD))
	(envelope-from <idefix@fechner.net>) id 1HTMP9-0006QB-1r
	for linuxppc-embedded@ozlabs.org; Mon, 19 Mar 2007 19:16:23 +0100
Date: Mon, 19 Mar 2007 19:16:23 +0100
From: Matthias Fechner <idefix@fechner.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Howto set DIO on MPC-5200 Lite
Message-ID: <20070319181622.GA24343@server.idefix.lan>
References: <918EB199DDDFFA42BEA2EB3A1C6021F360C085@CORREO>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <918EB199DDDFFA42BEA2EB3A1C6021F360C085@CORREO>
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

Hello Josu,

* Josu Onandia <jonandia@aotek.es> [19-03-07 14:18]:
> Some sample code. Hope this helps.
> 
> //   PSC2_0  ---->  J20 pin 2
> //   PSC2_1  ---->  J20 pin 4
> //   PSC2_2  ---->  J20 pin 6
> //   PSC2_3  ---->  J20 pin 8
> //
> //   GND ---- J20 pins 15,17,19,20

thx a lot for your code.
My problem is I have no documentation of the icecube board so I have
no idea which pin is connect to each other.

Have you possibly a documentation or schemtics from the icecube board
which you send send me?

Best regards,
Matthias

-- 

"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the universe trying to
produce bigger and better idiots. So far, the universe is winning." --
Rich Cook
