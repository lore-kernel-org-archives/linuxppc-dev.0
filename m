Return-Path: <blacklites@gmail.com>
Received: from mail-px0-f177.google.com (mail-px0-f177.google.com
	[209.85.216.177]) by ozlabs.org (Postfix) with ESMTP id 46E8BB7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 13 Oct 2009 00:34:44 +1100 (EST)
Received: by pxi7 with SMTP id 7so3280629pxi.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 12 Oct 2009 06:34:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20091009113338.2B7E3E84EBC@gemini.denx.de>
References: <a9b543570909230749g5bb9c302wa48f310250068f5b@mail.gmail.com>
	<1253742018.7103.333.camel@pasglop>
	<cb9ecdfa0910021017s5eece937ve7af90473d5a1a33@mail.gmail.com>
	<a9b543570910090320t1444f8f1qf4c8ab7dbbef679f@mail.gmail.com>
	<20091009113338.2B7E3E84EBC@gemini.denx.de>
Date: Mon, 12 Oct 2009 19:04:43 +0530
Message-ID: <a9b543570910120634n286693f3s15b39970ad9d1c74@mail.gmail.com>
Subject: Re: linux booting fails on ppc440x5 with SRAM
From: Vineeth _ <blacklites@gmail.com>
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johnny Hung <johnny.hacking@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wolfgang,

The link says about the initialization of the SDRAM; Does it
applicable in our case, where we have SRAM on our board. Does the
initialization means just clearing the memory in case of SRAM ? We
tried clearing the memory before the operation which doesnt work too.
We are creating a TLB of 16MB for the SRAM which is not cachable	.

-Vineeth

On Fri, Oct 9, 2009 at 5:03 PM, Wolfgang Denk <wd@denx.de> wrote:
> Dear Vineeth _,
>
> In message <a9b543570910090320t1444f8f1qf4c8ab7dbbef679f@mail.gmail.com> =
you wrote:
>> We ported the uboot Memory test and tested the 15MB ram and it was
>> successful.interestingly we have only 16MB SRAM in our board.We used 1
>
> Such a memory test means nothing. The only thing you can learn from it
> is that basic read and write accesses are working. You don;t get any
> information about the behaviour for burst mode accesses from such a
> test. See the FAQ at
> http://www.denx.de/wiki/view/DULG/LinuxCrashesRandomly =A0and at
> http://www.denx.de/wiki/DULG/UBootCrashAfterRelocation
>
> Best regards,
>
> Wolfgang Denk
>
> --
> DENX Software Engineering GmbH, =A0 =A0 MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> I mean, I . . . think to understand you, I just don't know =A0what =A0you
> are saying ... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0- Terry Pra=
tchett, _Soul Music_
>
