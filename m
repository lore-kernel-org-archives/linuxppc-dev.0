Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by ozlabs.org (Postfix) with ESMTP id B79E8DDF89
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Oct 2007 04:50:50 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2009311wag
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Oct 2007 11:50:49 -0700 (PDT)
Message-ID: <fa686aa40710231150o6b9a9b19h933edde94061ee59@mail.gmail.com>
Date: Tue, 23 Oct 2007 12:50:48 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: FDT bindings for I2C devices
In-Reply-To: <471E3DD8.4060508@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4718BB40.2050901@grandegger.com>
	<fa686aa40710190738q1211a266lced10ac8767e5071@mail.gmail.com>
	<471E3DD8.4060508@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 10/23/07, Scott Wood <scottwood@freescale.com> wrote:
> Grant Likely wrote:
> > Scott Wood made an attempt at defining a device binding for I2C
> > devices, but it has not been merged into booting-without-of.txt yet.
> > I've copied what he wrote below.  I would add to his definition the
> > following:
> > - If compatible is missing, driver should *not* fall back to the device name.
> > - 'compatible' list should include the exact device in the form "<mfg>,<part>"
>
> Those are good recommendations for any node, but I don't see why i2c in
> particular should mandate it.

I only mention it because the example given doesn't show that.

g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
