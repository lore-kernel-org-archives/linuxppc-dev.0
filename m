Return-Path: <chris.pagnotta@viasat.com>
Received: from VCAEXCH02.hq.corp.viasat.com (kestrel.viasat.com
	[199.106.52.139]) by ozlabs.org (Postfix) with ESMTP id 74A82DDE2A
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Dec 2007 09:26:28 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: ppcboot and powerpc branch question
Date: Fri, 30 Nov 2007 14:25:35 -0800
Message-ID: <821B2170E9E7F04FA38DF7EC21DE48710BA65802@VCAEXCH01.hq.corp.viasat.com>
In-Reply-To: <20071130221554.3AA0124075@gemini.denx.de>
References: Your message of "Fri, 30 Nov 2007 14:33:38
	+0100."<f8f856500711300533t3bad1c1dxb4ff137534acbccb@mail.gmail.com>
	<20071130221554.3AA0124075@gemini.denx.de>
From: "Pagnotta, Chris" <chris.pagnotta@viasat.com>
To: "Wolfgang Denk" <wd@denx.de>,
	"fabien" <fabien.fb@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Wolgang,

This question does pertain to the thread in question, but..

I am currently using your ELDK 4.1 Uclibc and have written various
scripts that allow it to be used with buildroot makefiles. Are you going
to releasing a newer version anytime soon?

Thanks,
Chris P.

-----Original Message-----
From: linuxppc-embedded-bounces+chris.pagnotta=3Dviasat.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+chris.pagnotta=3Dviasat.com@ozlabs.org]=

On Behalf Of Wolfgang Denk
Sent: Friday, November 30, 2007 2:16 PM
To: fabien
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: ppcboot and powerpc branch question

In message <f8f856500711300533t3bad1c1dxb4ff137534acbccb@mail.gmail.com>
you wrote:
>=20
> instead of bd_t struct. I'm a bit disappointed because i also see that
> older u-boot (in my case
> ppcboot 1.1.5) aren't capable to pass dts to kernel.

PPCBoot was a in a distant  past  before  U-Boot.  Actually,  PPCBoot
1.1.5 is more than 5 and a half years old. You cannot really expect a
Neanderthal man to drive a space shuttle.

> Is there a way to keep my old bootloader to boot a powerpc branch
kernel ?

No. Please use a current U-Boot (i. e. at least U-Boot 1.3.0).

Best regards,

Wolfgang Denk

--=20
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
As in certain cults it is possible to kill a process if you know  its
true name.                      -- Ken Thompson and Dennis M. Ritchie
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
