Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 76A1DDDE19
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 23:43:30 +1100 (EST)
To: Marian Balakowicz <m8@semihalf.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH v4 04/13] [POWERPC] Add generic support for simple MPC5200
	based boards
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 09 Nov 2007 18:12:02 +0100."
	<20071109171202.16289.2618.stgit@hekate.izotz.org>
Date: Sat, 10 Nov 2007 13:43:27 +0100
Sender: wd@denx.de
Message-Id: <20071110124327.1C46A248D3@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <20071109171202.16289.2618.stgit@hekate.izotz.org> you wrote:
> This patch adds support for 'mpc5200-simple-platform' compatible
> boards which do not need a platform specific setup. Such boards
> are supported assuming the following:
...
> +	const char *board[] = {	
> +		"tqc,tqm5200",
> +		"promess,motionpro",
> +		"schindler,cm5200",
> +		NULL
> +	};

would it make sense to sort this list alphabetiacally? At the moment
we can setill easily find each board, but assume that list grows to 50
boards names...

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
       There is enough for the need of everyone in this world,
       but not for the greed of everyone.     - Mahatma Gandhi
