Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 4C6BADDF8C
	for <linuxppc-dev@ozlabs.org>; Sat,  9 May 2009 05:18:15 +1000 (EST)
To: Alessandro Zummo <alessandro.zummo@towertech.it>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [rtc-linux] Re: [PATCH 10/12] mpc5121: Add MPC5121 Real time
	clock driver.
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <20090508180944.1304a8b7@i1501.lan.towertech.it>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-11-git-send-email-wd@denx.de>
	<20090506210644.GA17311@pengutronix.de>
	<fa686aa40905061540x96c1524hd88ee78bc366b89b@mail.gmail.com>
	<4b73d43f0905071941xaa78e4dj41f7396ff227af31@mail.gmail.com>
	<fa686aa40905080853q2156ba46w3d56d0285271ce43@mail.gmail.com>
	<20090508180944.1304a8b7@i1501.lan.towertech.it>
Date: Fri, 08 May 2009 21:18:10 +0200
Message-Id: <20090508191810.D51BE832C2FB@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, Piotr Ziecik <kosmo@semihalf.com>,
	rtc-linux@googlegroups.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Alessandro Zummo,

In message <20090508180944.1304a8b7@i1501.lan.towertech.it> you wrote:
> On Fri, 8 May 2009 09:53:20 -0600
> Grant Likely <grant.likely@secretlab.ca> wrote:
> 
> > That is fine by me, but since it is known that it will eventually
> > support both, I'd like it to be renamed to 5xxx before it is merged to
> > avoid a later rename patch.
> 
>  or 52xx ?

No, because the current version is for MPC5>1<2x

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Misquotation is, in fact, the pride and privilege of the  learned.  A
widely-read  man  never  quotes  accurately,  for  the rather obvious
reason that he has read too widely.
                - Hesketh Pearson _Common Misquotations_ introduction
