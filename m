Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 5F012DDE0A
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 05:49:15 +1100 (EST)
To: gianfranco.casanova@alice.it
From: Wolfgang Denk <wd@denx.de>
Subject: Re: USB on lite5200 does not work.
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <47602D18F269934AB73B7E550804A1E00213796C@FBCMST09V03.fbc.local>
References: <47602D18F269934AB73B7E550804A1E00213796C@FBCMST09V03.fbc.local>
Date: Thu, 20 Nov 2008 19:48:47 +0100
Message-Id: <20081120184847.0A37B832E89D@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear gianfranco.casanova@alice.it,

In message <47602D18F269934AB73B7E550804A1E00213796C@FBCMST09V03.fbc.local> you wrote:
> 
> I've got a "little" problem with USB using a board based on lite5200.
> 
> Some infos:
> 
> -uBoot 1.2.0
> -Linux version 2.6.21.7-hrt1-WR2.0bl_standard

2.6.21 is a pretty old kernel. In mainline, it  didn't  include  real
stable  support  for the MPC5200 yet, and I have no idea what WRS did
in this area (but I doubt they did much fixing there).

Please be aware that you are  using  a  highly  proprietary,  heavily
modified  kernel. You either want to ask Wind River support for help,
or try a recent mainline kernel.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
 The software required `Windows 95 or better', so I installed Linux.
