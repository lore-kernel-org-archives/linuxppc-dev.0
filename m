Return-Path: <linuxppc-embedded@ml.breakpoint.cc>
Date: Fri, 19 Sep 2008 10:12:31 +0200
From: Sebastian Siewior <linuxppc-embedded@ml.breakpoint.cc>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Device tree configuration for I2C eeprom
Message-ID: <20080919081231.GA9252@Chamillionaire.breakpoint.cc>
References: <16691A8B34B5D9458EA3A1C37A11555A0137F7B6@tanisys-ex2.Tanisys.Local>
	<20080918221335.GA6420@Chamillionaire.breakpoint.cc>
	<9e4733910809181521r3cd74119tfedd36567e3b5394@mail.gmail.com>
	<20080919050441.GD25528@secretlab.ca>
	<20080919071238.GA8773@Chamillionaire.breakpoint.cc>
	<20080919074458.GA7602@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20080919074458.GA7602@secretlab.ca>
Cc: Ayman El-Khashab <AymanE@tanisys.com>, devicetree-discuss@ozlabs.org,
	Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

* Grant Likely | 2008-09-19 00:44:58 [-0700]:

>Do not fall into the temptation of writing the device tree to reflect
>the current implementation of the operating system.  Stick to
>established conventions and documented bindings.
>
>That being said, it is a non-issue in this case.  The current Linux OF
>support code automagically strips off the manufacturer prefix when
>registering I2C devices.  Take a look at of_modalias_node() in
>drivers/of/base.c for details.
Thanks for this information.

>
>g.

Sebastian
