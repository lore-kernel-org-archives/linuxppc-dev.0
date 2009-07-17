Return-Path: <wd@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CD75BB7079
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 22:24:40 +1000 (EST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 6DB34DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jul 2009 22:24:38 +1000 (EST)
To: Grant Likely <grant.likely@secretlab.ca>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 1/2 v4] fs_enet/mii-fec.c: fix MII speed calculation
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <fa686aa40907161544je92317dy7abea6819746847@mail.gmail.com>
References: <1247671133-12148-1-git-send-email-wd@denx.de>
	<1247780546-4426-1-git-send-email-wd@denx.de>
	<fa686aa40907161544je92317dy7abea6819746847@mail.gmail.com>
Date: Fri, 17 Jul 2009 14:24:33 +0200
Message-Id: <20090717122433.6E7D0832E416@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Grant Likely,

In message <fa686aa40907161544je92317dy7abea6819746847@mail.gmail.com> you wrote:
>
> I assume this is tested.  I have not tested this on my board, and I've

It was tested, but as it turns out not quite well :-(

> got one question below, but otherwise I think I can say....
...
> The calculation has changed here for non mpc5121 users.  Shouldn't the
> "clock = ppc_proc_freq;" line above be "clock = ppc_proc_freq / 2;"?
> Or was this also a bug in the original driver?

You are right. That's a bug in the new code. Fixed in next version of
the patch.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Swap read error.  You lose your mind.
