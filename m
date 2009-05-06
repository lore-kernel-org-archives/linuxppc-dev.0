Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 8A1CEDDF91
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 08:41:37 +1000 (EST)
To: Grant Likely <grant.likely@secretlab.ca>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 02/12] fs_enet: Add MPC5121 FEC support.
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <fa686aa40905061529u11b231afle3b5bb10a2334ad0@mail.gmail.com>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-3-git-send-email-wd@denx.de>
	<fa686aa40905061333q29c263c8p24856c048e30f4d0@mail.gmail.com>
	<20090506220119.7322783420E8@gemini.denx.de>
	<fa686aa40905061529u11b231afle3b5bb10a2334ad0@mail.gmail.com>
Date: Thu, 07 May 2009 00:41:34 +0200
Message-Id: <20090506224134.83F1583420E8@gemini.denx.de>
Cc: Piotr Ziecik <kosmo@semihalf.com>, Detlev Zundel <dzu@denx.de>,
	netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Grant,

In message <fa686aa40905061529u11b231afle3b5bb10a2334ad0@mail.gmail.com> you wrote:
>
> > Agreed that it's ugly, but duplicatio9ng the code would have been even
> > worse. I don't think that it has multiplatform - at least not as long
> > as you don't ask for one image that runs on 83xx and on 512x.
> 
> Actually, I *am* asking for one image that runs on 83xx, 52xx and
> 521x.  I already can and do build and test a single image which boots
> on all my 52xx boards, on my 8349 board, and on my G4 Mac.

He. I was afraid you'd say that ;-)

In this case I need a helping hand as I can't figure out how to make
this work. Any suggestions?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Here's a fish hangs in the net like a poor man's right in  the  law.
'Twill hardly come out."     - Shakespeare, Pericles, Act II, Scene 1
