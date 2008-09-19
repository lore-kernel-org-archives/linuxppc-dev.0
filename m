Return-Path: <linuxppc-embedded@ml.breakpoint.cc>
Date: Fri, 19 Sep 2008 09:12:38 +0200
From: Sebastian Siewior <linuxppc-embedded@ml.breakpoint.cc>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Device tree configuration for I2C eeprom
Message-ID: <20080919071238.GA8773@Chamillionaire.breakpoint.cc>
References: <16691A8B34B5D9458EA3A1C37A11555A0137F7B6@tanisys-ex2.Tanisys.Local>
	<20080918221335.GA6420@Chamillionaire.breakpoint.cc>
	<9e4733910809181521r3cd74119tfedd36567e3b5394@mail.gmail.com>
	<20080919050441.GD25528@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20080919050441.GD25528@secretlab.ca>
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

* Grant Likely | 2008-09-18 22:04:41 [-0700]:

>No, don't use the generic chip names.  Device tree convention is to be
>specific and prefix the part number with the vendor name.  ie. You should
>be using "at,at24c64", not "24c64".

What about the i2c drivers which don't have any prefix like the m41t80?
Prior commit 0d1cde2 aka "powerpc/i2c: Convert i2c-mpc into an
of_platform driver" the ids were converted.

>
>g.
>

Sebastian
