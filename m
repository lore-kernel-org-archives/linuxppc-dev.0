Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id CCF96DDF03
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jan 2009 09:36:48 +1100 (EST)
To: Matteo Fortini <matteo.fortini@mta.it>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Booting uncompressed kernel image
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <497D9BC8.0@mta.it>
References: <497D9BC8.0@mta.it>
Date: Mon, 26 Jan 2009 23:36:45 +0100
Message-Id: <20090126223645.791B7832E416@gemini.denx.de>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Matteo Fortini,

In message <497D9BC8.0@mta.it> you wrote:
>
> I built an uncompressed uImage using mkimage --no-gzip -C none in the 
> wrapper scripts.

Hm... you must be using a funny version of mkimage, then. The cod in
mainline will bail out on "--no-gzip".

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
If I can have honesty, it's easier to overlook mistakes.
	-- Kirk, "Space Seed", stardate 3141.9
