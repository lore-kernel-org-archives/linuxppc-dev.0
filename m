Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id 7FEB9DDF5E
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jan 2008 05:38:40 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1148674anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Jan 2008 10:38:39 -0800 (PST)
Message-ID: <fa686aa40801031038v65b86934i99de48187f2a67b7@mail.gmail.com>
Date: Thu, 3 Jan 2008 11:38:39 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
In-Reply-To: <477D296A.6040202@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801012027p4be16b92r43af773f4e5ae531@mail.gmail.com>
	<477BADF5.9060003@freescale.com>
	<fa686aa40801020828u5103d09cn2aa5eab7dda2fcff@mail.gmail.com>
	<477D25F4.6020700@freescale.com>
	<fa686aa40801031025r10c31ce6x203755fe532f0c88@mail.gmail.com>
	<477D296A.6040202@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/3/08, Timur Tabi <timur@freescale.com> wrote:
> Grant Likely wrote:
>
> > Make the compatible property tell you!  :-)  If it's connected to an
> > I2S codec, then it could be compatible = "fsl,mpc8610-ssi,i2s".  Or
> > for AC7, compatible = "fsl,mpc8610-ssi,ac97"
>
> That won't work.  There are too many variations.  I think a separate property
> just makes more sense.  Frankly, I don't see what's wrong with it.

Sure it will, that's exactly what I'm doing with the 5200, but I won't
argue the point.  My *opinion* is that using compatible is a more
elegant approach for this type of multifunction device, but using a
mode property is neither wrong or bad.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
