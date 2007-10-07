Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 5339FDDE37
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Oct 2007 06:30:06 +1000 (EST)
To: "Grant Likely" <grant.likely@secretlab.ca>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 01/15] [POWERPC] TQM5200 DTS
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 07 Oct 2007 10:36:17 PDT."
	<fa686aa40710071036u164f2cbaob8cfa4ebc0b1ed1c@mail.gmail.com>
Date: Sun, 07 Oct 2007 22:30:03 +0200
Sender: wd@denx.de
Message-Id: <20071007203003.A3E03245B2@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, tech-denx@semihalf.com,
	Detlev Zundel <dzu@denx.de>, Marian Balakowicz <m8@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <fa686aa40710071036u164f2cbaob8cfa4ebc0b1ed1c@mail.gmail.com> you wrote:
>
> > +/ {
> > +       model = "fsl,tqm5200";
> 
> "fsl," is not appropriate as the TQM5200 is not a freescale product.
> We need a new abbreviation for tq-components.

How about

	model = "tqc,tqm5200";
?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Behind every great man, there is a woman -- urging him on.
	-- Harry Mudd, "I, Mudd", stardate 4513.3
