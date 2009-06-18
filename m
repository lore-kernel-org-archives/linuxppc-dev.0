Return-Path: <leon.woestenberg@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2EEDFB714E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 09:01:35 +1000 (EST)
Received: from mail-gx0-f210.google.com (mail-gx0-f210.google.com
	[209.85.217.210]) by ozlabs.org (Postfix) with ESMTP id 8036DDDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 09:01:34 +1000 (EST)
Received: by gxk6 with SMTP id 6so2070291gxk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 16:01:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A38DE83.1010405@aimvalley.nl>
References: <c384c5ea0906160852l4845760cp8594463a866683dc@mail.gmail.com>
	<4A38AADD.3070801@aimvalley.nl>
	<c384c5ea0906170309j6fdf28f5qc38129e82649ef28@mail.gmail.com>
	<4A38DE83.1010405@aimvalley.nl>
Date: Fri, 19 Jun 2009 01:01:32 +0200
Message-ID: <c384c5ea0906181601g28e3ac7frf2019b11bc34e057@mail.gmail.com>
Subject: Re: MPC83xx watchdog reset board dead lock
From: Leon Woestenberg <leon.woestenberg@gmail.com>
To: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>,
	David Hawkins <dwh@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Wed, Jun 17, 2009 at 2:16 PM, Norbert van
Bolhuis<nvbolhuis@aimvalley.nl> wrote:
>>
>> I'll be testing the design tomorrow on the reference board, I'll
>> report results in this thread.
>
> Interesting.
> Looking forward to the results.
>
Design works as expected on the now slightly modified MPC8313E-RDB
board. Kudos to David.

Cheers,
-- 
Leon
