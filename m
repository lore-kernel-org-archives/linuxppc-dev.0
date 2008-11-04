Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40811040828y23d0d65bsebc3f542c57291a@mail.gmail.com>
Date: Tue, 4 Nov 2008 09:28:16 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Sebastian Siewior" <linuxppc-embedded@ml.breakpoint.cc>
Subject: Re: Device tree configuration for I2C eeprom
In-Reply-To: <20080919071238.GA8773@Chamillionaire.breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <16691A8B34B5D9458EA3A1C37A11555A0137F7B6@tanisys-ex2.Tanisys.Local>
	<20080918221335.GA6420@Chamillionaire.breakpoint.cc>
	<9e4733910809181521r3cd74119tfedd36567e3b5394@mail.gmail.com>
	<20080919050441.GD25528@secretlab.ca>
	<20080919071238.GA8773@Chamillionaire.breakpoint.cc>
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

On Fri, Sep 19, 2008 at 12:12 AM, Sebastian Siewior
<linuxppc-embedded@ml.breakpoint.cc> wrote:
> * Grant Likely | 2008-09-18 22:04:41 [-0700]:
>
>>No, don't use the generic chip names.  Device tree convention is to be
>>specific and prefix the part number with the vendor name.  ie. You should
>>be using "at,at24c64", not "24c64".
>
> What about the i2c drivers which don't have any prefix like the m41t80?
> Prior commit 0d1cde2 aka "powerpc/i2c: Convert i2c-mpc into an
> of_platform driver" the ids were converted.

That is the *driver* not the device tree description.  The OF i2c code
is still converts the name.  By default it does this by simply
stripping off the manufacturer prefix, but the match table does still
exist when the default behavior needs to be overridden.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
