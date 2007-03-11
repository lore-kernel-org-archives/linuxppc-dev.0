Return-Path: <idefix@fechner.net>
Received: from michelle.lostinspace.de (michelle.lostinspace.de
	[62.146.248.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "michelle.lostinspace.de",
	Issuer "michelle.lostinspace.de" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BEBDCDDE32
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 11 Mar 2007 12:02:01 +1100 (EST)
Received: from server.idefix.lan (cl-70.muc-02.de.sixxs.net
	[IPv6:2001:a60:f000:45::2]) (authenticated bits=0)
	by michelle.lostinspace.de (8.13.8/8.13.8) with ESMTP id l2B11o9v077990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 11 Mar 2007 02:01:55 +0100 (CET)
	(envelope-from idefix@fechner.net)
Received: from idefix by server.idefix.lan with local (Exim 4.66 (FreeBSD))
	(envelope-from <idefix@fechner.net>) id 1HQCRa-000Am1-7b
	for linuxppc-embedded@ozlabs.org; Sun, 11 Mar 2007 02:01:50 +0100
Date: Sun, 11 Mar 2007 02:01:50 +0100
From: Matthias Fechner <idefix@fechner.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: where and how to get the latest 2.6 kernel
Message-ID: <20070311010149.GB39488@server.idefix.lan>
References: <20070307122430.GA73298@server.idefix.lan>
	<4b73d43f0703071317o7ae5e531s5eb4b390d41a1b88@mail.gmail.com>
	<20070309113506.GB6726@server.idefix.lan>
	<4b73d43f0703090911y3c2898cdmfdb84f8c7f5da8f@mail.gmail.com>
	<20070309234251.GA68997@server.idefix.lan>
	<45F21567.3050008@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45F21567.3050008@rogers.com>
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

Hello Nick,

* Nick Droogh <ndroogh@rogers.com> [09-03-07 21:18]:
> I have a mpc5200b based board and I would like to upgrade to the 2.6 
> kernel from 2.4.  Is there a document explaining where to get the 
> latests git version, and where to find the xenomai patch?

I used the git version from denx.de.
To get the Xenomai patch into the kernel I have to edit one file
manually but it was quit easy.

Best regards,
Matthias

-- 

"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the universe trying to
produce bigger and better idiots. So far, the universe is winning." --
Rich Cook
