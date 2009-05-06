Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 83BDBDE06F
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 08:14:43 +1000 (EST)
To: Grant Likely <grant.likely@secretlab.ca>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 04/12] mpc5121: Added reset module registers
	representation.
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <fa686aa40905061339u171559b8va45c210b3e63cf83@mail.gmail.com>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-5-git-send-email-wd@denx.de>
	<fa686aa40905061339u171559b8va45c210b3e63cf83@mail.gmail.com>
Date: Thu, 07 May 2009 00:14:40 +0200
Message-Id: <20090506221440.DDF8E83420E8@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, Piotr Ziecik <kosmo@semihalf.com>,
	Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Grant Likely,

In message <fa686aa40905061339u171559b8va45c210b3e63cf83@mail.gmail.com> you wrote:
>
> No patch description.  I would also like to see this patch merged with
> the actual user of it since it is so small.

Will do. As for description - the Subject says it all.

> > +} __attribute__ ((__packed__));
> 
> __attribute__((__packed__)); is unnecessary.

OK.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Applying computer technology is simply finding the  right  wrench  to
pound in the correct screw.
