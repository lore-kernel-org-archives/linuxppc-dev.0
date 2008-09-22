Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id B58BDDDF86
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Sep 2008 20:49:45 +1000 (EST)
To: Peter Korsgaard <jacmet@sunsite.dk>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH v2] bootwrapper: support u-boot multi component images
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <874p48y5qb.fsf@macbook.be.48ers.dk>
References: <1221814210-4738-1-git-send-email-jacmet@sunsite.dk>
	<20080922074128.A66F22487F@gemini.denx.de>
	<874p48y5qb.fsf@macbook.be.48ers.dk>
Date: Mon, 22 Sep 2008 12:49:43 +0200
Sender: wd@denx.de
Message-Id: <20080922104943.24395248EE@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Peter,

In message <874p48y5qb.fsf@macbook.be.48ers.dk> you wrote:
> 
>  Wolfgang> NAK.
> 
>  Wolfgang> Please do not add such a patch to mainline.
> 
> I agree that FIT images probably are the way to go for the future, but
> I do think there's room for uImage.% just like we have cuImage.% for
> really old uboots.

I disagree. Adding such support now just encourages people  to  start
using a deprecated feature.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Parkinson's Law:  Work expands to fill the time alloted it.
