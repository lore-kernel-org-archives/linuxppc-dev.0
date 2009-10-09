Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20091009051409.GA2361@pengutronix.de>
References: <1255010672-21656-1-git-send-email-w.sang@pengutronix.de>
	<20091008143301.GA6084@oksana.dev.rtsoft.ru>
	<fa686aa40910080753v6f597b0h4ce835db9f7a653@mail.gmail.com>
	<20091008151007.GA21328@oksana.dev.rtsoft.ru>
	<fa686aa40910080848r459c47baob73fc70a95a08604@mail.gmail.com>
	<20091008202723.GA8116@pengutronix.de>
	<20091009051409.GA2361@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 8 Oct 2009 23:40:47 -0600
Message-ID: <fa686aa40910082240w7fb2a194tcc80e7afe182e781@mail.gmail.com>
Subject: Re: [RFC] misc/at24: add experimental OF support for the generic
	eeprom driver
To: Wolfram Sang <w.sang@pengutronix.de>, Nate Case <ncase@xes-inc.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	linux-i2c@vger.kernel.org, linux-embedded@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 8, 2009 at 11:14 PM, Wolfram Sang <w.sang@pengutronix.de> wrote=
:
>> Will check this tomorrow.
>
> And while doing this and figuring the pro/cons of those methods, I stumbl=
ed over this commit:
>
> =A0 =A0 =A0 =A0gpio: pca953x: Get platform_data from OpenFirmware
> =A0 =A0 =A0 =A0(1965d30356c1c65660ba3330927671cfe81acdd5)
>
> It looks to me that it missed all people involved in OF/DT-development an=
d now we
> have undocumented and IMO questionable properties in the kernel.

Hi Nate,

For your future reference, patches that look at the device tree should
also cc: devicetree-discuss@lists.ozlabs.org so that new bindings can
be reviewed and common mistakes can be avoided.  It is expected that
new device tree bindings are accompanied with documentation describing
what the binding is for and how it should be used (see
Documentation/powerpc/dts-bindings).

I know this change is already in mainline, but can you please post the
device tree fragment that you're using to describe this chip?  I want
to make sure we don't get stuck with things in the kernel that will be
hard to maintain in the long term.

Thanks,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
