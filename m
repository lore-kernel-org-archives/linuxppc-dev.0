Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id 11A4CDDE1E
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jan 2008 11:35:11 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1077831anc.78
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Jan 2008 16:35:09 -0800 (PST)
Message-ID: <fa686aa40801131635o499c8c08i6a2667cd7df1a72e@mail.gmail.com>
Date: Sun, 13 Jan 2008 17:35:09 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: I2C and CAN bus on MPC5200B device tree
In-Reply-To: <478A967E.7080201@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <478A967E.7080201@genesi-usa.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/13/08, Matt Sealey <matt@genesi-usa.com> wrote:
>
> Hi guys,
>
> I know the I2C stuff is up in the air (I cannot pinpoint the documentation
> for it) and have not found any CAN bus documentation for device trees.
>
> I want to update the firmware tree to add these but, am basically looking
> for those docs, or someone to go over a few points.. is there some kind of
> tree standard I should be looking at, or some patch I missed which has
> a driver which implements something that looks at a compatible tree?

I think some consensus has been achieved for describing i2c busses and
their attached devices, but I don't think booting-without-of.txt has
been updated with the details yet.  I need to look into that more.

I don't think anyone has tackled CAN.  Best bet is to draft a tree in
the way you think it should be described and post it to the list.
That will give a starting point for us to discuss it and come to
consensus.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
