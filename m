Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 193572BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Oct 2004 07:14:31 +1000 (EST)
Date: Wed, 13 Oct 2004 14:14:28 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Matt Porter <mporter@kernel.crashing.org>
Message-ID: <20041013211428.GB28349@gate.ebshome.net>
References: <065ACD8E84315E4394C835E398C8D5EB865270@COSSMGMBX02.email.corp.tld>
	<20041013132613.A21277@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20041013132613.A21277@home.com>
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>, "VanBaren,
	Gerald \(AGRE\)" <Gerald.VanBaren@smiths-aerospace.com>
Subject: Re: "I2C" versus "IIC"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Oct 13, 2004 at 01:26:13PM -0700, Matt Porter wrote:
> On Wed, Oct 13, 2004 at 02:18:03PM -0600, VanBaren, Gerald (AGRE) wrote:
> > Just to mess with your minds... I2C is a trademark of Philips
> > Electronics N.V. so that is probably not the best choice from a
> > legalistic point of view.
> 
> It's been related to me several times that this is the reason why
> most implementers refer to their interface/bus as IIC in
> documentation.

Yeah, the most "extreme" variant being "two-wire serial interface", 
without even mentioning I2C or IIC.

You need some familiarity with bus protocol to figure out that this is 
really I2C :).

--
Eugene
