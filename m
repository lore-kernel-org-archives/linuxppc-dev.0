Return-Path: <idefix@fechner.net>
Received: from michelle.lostinspace.de (michelle.lostinspace.de
	[62.146.248.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "michelle.lostinspace.de",
	Issuer "michelle.lostinspace.de" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A6E3FDDDEB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Mar 2007 15:31:02 +1100 (EST)
Received: from server.idefix.lan (cl-70.muc-02.de.sixxs.net
	[IPv6:2001:a60:f000:45::2]) (authenticated bits=0)
	by michelle.lostinspace.de (8.13.8/8.13.8) with ESMTP id l2D4Uprw098085
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Mar 2007 05:30:56 +0100 (CET)
	(envelope-from idefix@fechner.net)
Received: from idefix by server.idefix.lan with local (Exim 4.66 (FreeBSD))
	(envelope-from <idefix@fechner.net>) id 1HQyex-000Lwn-5z
	for linuxppc-embedded@ozlabs.org; Tue, 13 Mar 2007 05:30:51 +0100
Date: Tue, 13 Mar 2007 05:30:51 +0100
From: Matthias Fechner <idefix@fechner.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Problem in compiling a kernel module
Message-ID: <20070313043050.GB82243@server.idefix.lan>
References: <20070312170030.GA5613@server.idefix.lan>
	<528646bc0703121136g628bcaf7if0ef36f87d27dc6b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <528646bc0703121136g628bcaf7if0ef36f87d27dc6b@mail.gmail.com>
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

Hello Grant,

* Grant Likely <grant.likely@secretlab.ca> [12-03-07 12:36]:
> Looks like you're trying to access inital data (which is freed after
> module load) from regular code (which is not)

is it possible to find the line of code with the address is these
warnings?

Best regards,
Matthias

-- 

"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the universe trying to
produce bigger and better idiots. So far, the universe is winning." --
Rich Cook
