Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id A2BF3DDE4A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Aug 2007 09:28:03 +1000 (EST)
To: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: ppc_8xx-gcc from eldk strange behaviour
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 29 Aug 2007 11:28:36 +0200."
	<F1F6EC0C8B75034F9E3A79FC85122E8EA185B5@aquib01a>
Date: Thu, 30 Aug 2007 01:28:00 +0200
Sender: wd@denx.de
Message-Id: <20070829232800.EBD0524044@gemini.denx.de>
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

In message <F1F6EC0C8B75034F9E3A79FC85122E8EA185B5@aquib01a> you wrote:
> > C does not specify the signedness of char.  If you care, you need to
> > explicitly specify.
> 
> Sorry, I didn't know this. Anyway I would expect the same behaviour from
> both host gcc and ppc_8xx-gcc. In this case host gcc is wrong. 

No, it is not wrong.  The  behaviour  is  just  not  defined  by  the
standard,  so  the compiler is free to do what he likes. Some systems
default to singend chars,  others  to  unsigned.  Both  is  perfectly
legal.

It is code that makes any such assumptions which is broken.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Death, when unnecessary, is a tragic thing.
	-- Flint, "Requiem for Methuselah", stardate 5843.7
