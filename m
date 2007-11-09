Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by ozlabs.org (Postfix) with ESMTP id B41BCDDF18
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 01:52:16 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id b2so81810ana
	for <linuxppc-dev@ozlabs.org>; Fri, 09 Nov 2007 06:52:13 -0800 (PST)
Message-ID: <fa686aa40711090652xa398f89y188f4a6d41ec7e5f@mail.gmail.com>
Date: Fri, 9 Nov 2007 07:52:11 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Marian Balakowicz" <m8@semihalf.com>
Subject: Re: [PATCH v3 04/13] [POWERPC] Add generic support for simple MPC5200
	based boards
In-Reply-To: <4734721A.6030603@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40711061304k4779d01cu7fd1b17d1d34e5a2@mail.gmail.com>
	<20071106222224.D67BA2479C@gemini.denx.de>
	<fa686aa40711061525y79f9f99eneda32b09a77ddcd5@mail.gmail.com>
	<4734721A.6030603@semihalf.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/9/07, Marian Balakowicz <m8@semihalf.com> wrote:
> I can imagine that we may get into various trouble (or at least the
> situation is less flexible) if we are unable to update .dts file along
> with the kernel image on a deployed board. If so, then in fact there
> is little sens in using "mpc5200-simple-platform" compatible.
>
> But how serious is that, does such situation frequently happen in
> field? If we are able to update kernel image than what prevents .dts
> file update?

Not everything in the device tree is in the .dts file.  U-boot or
other firmware can modify the device tree before passing it to the
kernel.  It may not always be possible to update the device tree
without also updating the firmware.  I already know of changes that
I'd like to make to the lite5200 tree which I know will break u-boot.

That isn't the situation in this particular case, but we must always
keep it in mind.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
