Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6E297DDF59
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 05:20:33 +1000 (EST)
Date: Thu, 6 Sep 2007 14:20:25 -0500
From: Scott Wood <scottwood@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 8/9] 8xx: Adder 875 support
Message-ID: <20070906192025.GA22775@ld0162-tx32.am.freescale.net>
References: <20070905192820.GG32398@ld0162-tx32.am.freescale.net>
	<85281ec227e35a9e466e68e3fdc7e6ef@kernel.crashing.org>
	<20070906141620.GB16353@ld0162-tx32.am.freescale.net>
	<f26578467468e38345e795ea5f1f7c42@kernel.crashing.org>
	<20070906180922.GA18750@ld0162-tx32.am.freescale.net>
	<598e0baf0dc1ca63b91f2a80ec8abe19@kernel.crashing.org>
	<20070906191255.GA22663@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070906191255.GA22663@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 06, 2007 at 02:12:55PM -0500, Scott Wood wrote:
> On Thu, Sep 06, 2007 at 08:48:12PM +0200, Segher Boessenkool wrote:
> > So it should be "Adder MPC875", then :-)
> 
> Any particular reason to leave out potentially useful information in a
> field that is for human consumption?
> 
> Other than Because Segher Says So(tm). :-)

BTW, IEEE1275 seems to disagree:

  "model"

  Standard property name to define a manufacturer's model number.

  prop-encoded-array:
    Text string, encoded with encode-string.

  A manufacturer-dependent string that generally specifies the model name
  and number (including revision level) for this device. The format of
  the text string is arbitrary, although in conventional usage the string
  begins with the name of the device's manufacturer as with the name
  property.

  Although there is no standard interpretation for the value of the model
  property, a specific device driver might use it to learn, for instance,
  the revision level of its particular device.

  See also: property, model.
  Used as: " XYZCO,1416-02" encode-string " model" property

-Scott
