Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 53648DDE17
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Jul 2008 20:59:58 +1000 (EST)
To: "Rami WEHBI" <rwehbi@wirecom-tech.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: linux boot sequence
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 11 Jul 2008 08:34:54 +0200."
	<D3C541E264C021479BFB60B3B790C0FB497014@etoilenoire.STARWARS.local>
Date: Sat, 12 Jul 2008 12:59:55 +0200
Sender: wd@denx.de
Message-Id: <20080712105955.D3A0B242FF@gemini.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <D3C541E264C021479BFB60B3B790C0FB497014@etoilenoire.STARWARS.local> you wrote:
> 
>     I am using the ppc405 and I would like to know, how does linux on
> this architect detect the available memory size in details !!!
>         is it a parameter passed to linux at startup by the boot loader
> ??

Yes.


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The more complex the mind, the greater the need for the simplicity of
play.
	-- Kirk, "Shore Leave", stardate 3025.8
