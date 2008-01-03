Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id 9ECFDDDF7B
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jan 2008 05:17:02 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1147066anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Jan 2008 10:17:01 -0800 (PST)
Message-ID: <fa686aa40801031017n42f6fbf1nb2da5097ef13cf3c@mail.gmail.com>
Date: Thu, 3 Jan 2008 11:17:00 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
In-Reply-To: <477D24AA.4050804@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
	<9e4733910801010942y47e4cdbfge5e0d3e44ab96760@mail.gmail.com>
	<477BAB67.4080003@freescale.com>
	<fa686aa40801020812o471e18e6u9fe20676d320e958@mail.gmail.com>
	<477D24AA.4050804@freescale.com>
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
> > Why not be a child of the i2c bus with a phandle to the ssi bus?
>
> Because when I probe the SSI node, I want to know what the attached codec is.
>   So if anything, I would need a pointer from the SSI bus *to* the respective
> child on the I2C bus.

That's fine too (it's what is done with Ethernet PHYs).  My preference
is the other way around, but it's not a big issue in this case.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
