Return-Path: <wd@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 81F70B708A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 22:25:36 +1000 (EST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id C4B5ADDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jul 2009 22:25:35 +1000 (EST)
To: Grant Likely <grant.likely@secretlab.ca>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 2/2 v2] MPC52xx FEC: be more conservative when setting
	MII_SPEED register
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <fa686aa40907161548n1658afaei8dce2d893222019c@mail.gmail.com>
References: <1247671133-12148-1-git-send-email-wd@denx.de>
	<1247780546-4426-2-git-send-email-wd@denx.de>
	<fa686aa40907161548n1658afaei8dce2d893222019c@mail.gmail.com>
Date: Fri, 17 Jul 2009 14:25:33 +0200
Message-Id: <20090717122533.09431832E416@gemini.denx.de>
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

In message <fa686aa40907161548n1658afaei8dce2d893222019c@mail.gmail.com> you wrote:
> 
> Mostly good.  One comment below.  When it's resolved, feel free to add
> my acked-by line.  Thanks for getting this done.
...
> Just thought of something.  If it cannot find the clock, then wouldn't
> it be better to just use the maximum divider and print a warning
> instead of bailing completely?  This goes for the other patch as well.

Will change this for both patches. Thanks.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Program maintenance is an entropy-increasing process,  and  even  its
most skilfull execution only delays the subsidence of the system into
unfixable obsolescence.       - Fred Brooks, "The Mythical Man Month"
