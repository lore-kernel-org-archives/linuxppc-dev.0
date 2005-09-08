Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9F801681CC
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Sep 2005 16:31:39 +1000 (EST)
Date: Wed, 7 Sep 2005 23:31:36 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Albert David <albert.david@gmail.com>
Message-ID: <20050908063136.GA22596@gate.ebshome.net>
References: <61124de7050907230383654a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <61124de7050907230383654a6@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: BDI2000 with PPC405EP
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Sep 08, 2005 at 11:33:53AM +0530, Albert David wrote:
> Friends,
> I have been trying to find a solution to fix "PPC: timeout while
> waiting for freeze" for my custom board.
> BDI2000 keeps resetting the system with the following message...
> 
> TARGET: processing user reset request
> TARGET: resetting target passed
> TARGET: processing target startup ....
> *** TARGET: core #0 startup failed # PPC: timeout while waiting for freeze
> TARGET: target will be restarted in 10 sec
> 
> I tried all the possible solutions provided at
> http://www.ultsol.com/faq-P206.htm for this perticular behaviour but
> the problem remains same!
> 
> I have ensured that my Board's JTAG interface is properly working by
> boundary scanning the pins of PPC405EP using UniversalScan software
> with Altera-ByteBlaster MV.
> 
> for your information: twice i could succeed connecting BDI2000 with my
> target! somehow it happen to work while i was trying to execute low
> level JTAG commands such as 'rir' rdr'  and then after exiting(JTAG
> command shell of BDI) it worked, but there is no consistency!
> 
> looks like my cpu core is not halting after asserting HALT line.
> has anyone faced similar problem??

In _all_ cases I saw this problem it was a hw bug. Ask your hw 
engineers to help you. Start with the usual suspects: power, clocks, 
strapping, etc.

I don't think working boundary scan is an indication that hw design is 
OK.

-- 
Eugene
