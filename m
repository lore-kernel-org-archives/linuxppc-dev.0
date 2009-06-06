Return-Path: <wd@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 86102B70A8
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  7 Jun 2009 08:07:31 +1000 (EST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id BDB09DDD0B
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Jun 2009 08:07:29 +1000 (EST)
To: David Jander <david.jander@protonic.nl>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [RFC][PATCH v5] MPC5121 TLB errata workaround
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <200903161652.09747.david.jander@protonic.nl>
References: <200903161652.09747.david.jander@protonic.nl>
Date: Sun, 07 Jun 2009 00:07:23 +0200
Message-Id: <20090606220723.A38DA832E416@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	gunnar@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear David Jander,

In message <200903161652.09747.david.jander@protonic.nl> you wrote:
> Complete workaround for DTLB errata in e300c2/c3/c4 processors.
> 
> Due to the bug, the hardware-implemented LRU algorythm always goes to way
> 1 of the TLB. This fix implements the proposed software workaround in
> form of a LRW table for chosing the TLB-way.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> Signed-off-by: David Jander <david@protonic.nl>

What is the actual status of this patch?

Patchwork (http://patchwork.ozlabs.org/patch/24502/) says it's
"superseded" - but by what?

I can't see such code in mainline - what happened to it?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
One essential to success is that you desire be an all-obsessing  one,
your thoughts and aims be co-ordinated, and your energy be concentra-
ted and applied without letup.
