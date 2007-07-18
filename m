Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 11555DDF75
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 02:36:04 +1000 (EST)
Message-ID: <469E416E.8040709@freescale.com>
Date: Wed, 18 Jul 2007 11:35:58 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH 52/61] cpm_uart: Issue STOP_TX command before initializing
	console.
References: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>	<20070718013608.GX15238@ld0162-tx32.am.freescale.net>
	<20070718120022.1b007937@localhost.localdomain>
In-Reply-To: <20070718120022.1b007937@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Vitaly Bordug wrote:
>>+	cpm_line_cr_cmd(pinfo, CPM_CR_STOP_TX);
>>+
> 
> 
> I am recalling exactly the contrary patch that removes stuff to get the non-console UARTs work.
> Let's better revalidate this once other pieces will be in before applying.

I tried non-console UARTs and had no problem...  How would this 
interfere with them?  Especially as we're only doing it in the console 
init path...

-Scott
