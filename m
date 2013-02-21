Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 802CB2C007A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2013 10:47:36 +1100 (EST)
Message-ID: <1361490453.4676.59.camel@pasglop>
Subject: Re: PS3: Strange issue with kexec and FreeBSD loader
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Phileas Fogg <phileas-fogg@mail.ru>
Date: Thu, 21 Feb 2013 17:47:33 -0600
In-Reply-To: <51269A4B.1020501@mail.ru>
References: <1360365046.495584377@f356.mail.ru> <5123C729.5040607@mail.ru>
 <5123D864.4060503@mail.ru> <51253558.1070407@mail.ru>
 <1361406741.4676.44.camel@pasglop> <512685B7.5080404@mail.ru>
 <1361478942.4676.53.camel@pasglop> <51269A4B.1020501@mail.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-02-21 at 23:06 +0100, Phileas Fogg wrote:
> Does it look like the new data at offset 0x80 and 0x88 in DT are MSR
> flags 
> MSR_DR, MSR_IR and MSR_EE ?

Yes, that looks plausible though I would have expected ME to be set as
well ... Or it could be a CCR value. But it does look like something
splattered the DT as if it was a stack... ie, bad r1 value.

Cheers,
Ben.
