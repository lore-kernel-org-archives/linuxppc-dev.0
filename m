Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 373E0DE1E8
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 03:59:17 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so626858ywt.39
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 10:59:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <38563D01-3F19-480A-AC65-743A0A2318BE@kernel.crashing.org>
References: <1242806865-2334-1-git-send-email-w.sang@pengutronix.de>
	<9e4733910905200817w20a812bcy14481255fefd011f@mail.gmail.com>
	<20090520155346.GG29102@pengutronix.de>
	<9e4733910905200910r5342c087pa4ebc579b37c8671@mail.gmail.com>
	<20090520161511.GH29102@pengutronix.de>
	<fa686aa40905200925o763179c7r27c12f7659560807@mail.gmail.com>
	<fa686aa40905200936o63f47937rda28126ce0f46aad@mail.gmail.com>
	<38563D01-3F19-480A-AC65-743A0A2318BE@kernel.crashing.org>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 21 May 2009 11:58:56 -0600
Message-ID: <fa686aa40905211058h76dfea91sbccf2903b9218c49@mail.gmail.com>
Subject: Re: [PATCH] powerpc/pcm030.dts: add i2c eeprom and delete cruft
To: Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 21, 2009 at 11:43 AM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>> However, on the other point, Jon is correct. =A0The first value in the
>> list should be "atmel,24c32", not "at24,24c32".
>
> Yeah. =A0So perhaps "atmel,24c32","24c32" ? =A0I'm not terribly happy
> with that last name, but these devices are _very_ common.

I don't think the last name is necessary at all.  I'd leave it at
"atmel,24c32".  non-atmel parts can claim compatibility with the atmel
version if really necessary.  I don't like the 'generic' version
either.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
