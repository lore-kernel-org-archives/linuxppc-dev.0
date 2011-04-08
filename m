Return-Path: <timur.tabi@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 91319B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  9 Apr 2011 01:30:04 +1000 (EST)
Received: by fxm5 with SMTP id 5so2716481fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 08 Apr 2011 08:30:00 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <327152.93855.qm@web36406.mail.mud.yahoo.com>
References: <327152.93855.qm@web36406.mail.mud.yahoo.com>
From: Timur Tabi <timur@freescale.com>
Date: Fri, 8 Apr 2011 10:29:20 -0500
Message-ID: <BANLkTi=o2uEq9jeU0J+rRBUcXd1ukGdjqQ@mail.gmail.com>
Subject: Re: Using dmaengine on Freescale P2020 RDB
To: Chuck Ketcham <chuckk2333@yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 6, 2011 at 2:40 PM, Chuck Ketcham <chuckk2333@yahoo.com> wrote:

> Three of the channels were not used because they were already publicly al=
located. =A0One channel was
> not used because it didn't have DMA_MEMCPY capability.

That's strange, because all four DMA channels are identical.

> 2. If dmaengine is correct, what can I do to free up a channel for my own=
 use?

There must be something else in your system using up the channels.

--=20
Timur Tabi
Linux kernel developer at Freescale
