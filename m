Return-Path: <idefix@fechner.net>
Received: from michelle.lostinspace.de (michelle.lostinspace.de
	[62.146.248.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "michelle.lostinspace.de",
	Issuer "michelle.lostinspace.de" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A495FDDD0D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Mar 2007 15:27:18 +1100 (EST)
Received: from server.idefix.lan (cl-70.muc-02.de.sixxs.net
	[IPv6:2001:a60:f000:45::2]) (authenticated bits=0)
	by michelle.lostinspace.de (8.13.8/8.13.8) with ESMTP id l2F4R6bG045104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Mar 2007 05:27:11 +0100 (CET)
	(envelope-from idefix@fechner.net)
Received: from idefix by server.idefix.lan with local (Exim 4.66 (FreeBSD))
	(envelope-from <idefix@fechner.net>) id 1HRhYQ-000N0r-Bn
	for linuxppc-embedded@ozlabs.org; Thu, 15 Mar 2007 05:27:06 +0100
Date: Thu, 15 Mar 2007 05:27:06 +0100
From: Matthias Fechner <idefix@fechner.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Problem in compiling a kernel module
Message-ID: <20070315042705.GA82877@server.idefix.lan>
References: <20070313043050.GB82243@server.idefix.lan>
	<513703.69187.qm@web302.biz.mail.mud.yahoo.com>
	<20070314043305.GB27011@server.idefix.lan>
	<20070314065411.GD14658@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070314065411.GD14658@moe.telargo.com>
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

Hello Domen,

* Domen Puncer <domen.puncer@telargo.com> [14-03-07 07:54]:
> __initdata
> 
> > 
> > void max6633_cleanup(void)
> > {
> >    int res;
> >    if(max6633_initialized==1)
> 
> But you access it from non-init code.

ah ok, I rechecked the docu in the kernel now again and found a small
line that mentioned that. I have easily written the code from the docu.
But now it will be linked fine.

Thx a lot, now a lot of thinks got clearer and I understood some steps.

Best regards,
Matthias

-- 

"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the universe trying to
produce bigger and better idiots. So far, the universe is winning." --
Rich Cook
