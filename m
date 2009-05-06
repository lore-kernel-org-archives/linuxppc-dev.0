Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f172.google.com (mail-gx0-f172.google.com
	[209.85.217.172]) by ozlabs.org (Postfix) with ESMTP id DD691DDF94
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 08:39:48 +1000 (EST)
Received: by gxk20 with SMTP id 20so785157gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 06 May 2009 15:39:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090506220954.5D3AF83420E8@gemini.denx.de>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-3-git-send-email-wd@denx.de>
	<4A01F602.2010601@freescale.com>
	<20090506220954.5D3AF83420E8@gemini.denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 6 May 2009 16:39:25 -0600
Message-ID: <fa686aa40905061539t4fa463aehe56fdb64d053135d@mail.gmail.com>
Subject: Re: [PATCH 02/12] fs_enet: Add MPC5121 FEC support.
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Piotr Ziecik <kosmo@semihalf.com>, Detlev Zundel <dzu@denx.de>,
	John Rigby <jrigby@gmail.com>, netdev@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 6, 2009 at 4:09 PM, Wolfgang Denk <wd@denx.de> wrote:
> Dear Scott,
>
> in message <4A01F602.2010601@freescale.com> you wrote:
>>
>> All of the above is duplicative (with even the same names) of stuff in
>> asm/cpm.h. =A0Beyond just the duplication, what happens if both CPM2 and
>
> OK, I can try to reuse the definitions from that file.
>
>> 512x are enabled in the same kernel?
>
> Hm... both architectures look sufficiently different to me that I
> don't see sense in trying such a thing. Do you think that needs to be
> supported?

Yes!  :-)  It's not hard to do and it keeps the driver cleaner
(IMNSHO).  I don't think it is quite possible at the moment due to
cache coherency issues, but with Becky's recently merged dma ops
changes it should be fixable.

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
