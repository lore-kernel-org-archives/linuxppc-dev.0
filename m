Return-Path: <idefix@fechner.net>
Received: from michelle.lostinspace.de (michelle.lostinspace.de
	[62.146.248.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "michelle.lostinspace.de",
	Issuer "michelle.lostinspace.de" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 54F5CDDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Mar 2007 20:48:30 +1100 (EST)
Received: from server.idefix.lan (cl-70.muc-02.de.sixxs.net
	[IPv6:2001:a60:f000:45::2]) (authenticated bits=0)
	by michelle.lostinspace.de (8.13.8/8.13.8) with ESMTP id l2J9mKj6093441
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Mar 2007 10:48:25 +0100 (CET)
	(envelope-from idefix@fechner.net)
Received: from [192.168.0.151]
	by server.idefix.lan with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.66 (FreeBSD)) (envelope-from <idefix@fechner.net>)
	id 1HTETS-000JHr-F8
	for linuxppc-embedded@ozlabs.org; Mon, 19 Mar 2007 10:48:20 +0100
Message-ID: <45FE5C63.5040800@fechner.net>
Date: Mon, 19 Mar 2007 10:48:19 +0100
From: Matthias Fechner <idefix@fechner.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: Howto set DIO on MPC-5200 Lite
References: <BAY122-F7DD64EA831188A2BEA9FACA760@phx.gbl>
In-Reply-To: <BAY122-F7DD64EA831188A2BEA9FACA760@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi Pedro and Sylvain,

Pedro Luis D. L. wrote:
> Could you mean "GIO" ports?

I mean the digital IO ports ok or general IO ports.
What I want is to set a signal to high or low which should control a relais.

I thought I can use the pin Dxx for that on the board.

Best regards,
Matthias

-- 

"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the universe trying to
produce bigger and better idiots. So far, the universe is winning." --
Rich Cook
