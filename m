Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0C351DDE98
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Jul 2008 03:46:28 +1000 (EST)
Date: Fri, 11 Jul 2008 12:46:04 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: <rmcguire@videopresence.com>
Subject: Re: Freescale UCC_GETH Half Duplex Patch
Message-Id: <20080711124604.caf199e9.kim.phillips@freescale.com>
In-Reply-To: <2FE8E39946EE489FBAFC327EC9154EAF@absolutdaddy>
References: <2FE8E39946EE489FBAFC327EC9154EAF@absolutdaddy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 10 Jul 2008 17:23:31 -0700
"Russell McGuire" <rmcguire@videopresence.com> wrote:

Hi Russel,

> Here is a fix up for the UCC_GETH driver supporting half duplex mode for
> some specific modes.
> 
> I have tested this quiet extensively and the link now comes up and works,
> however not sure if there are other issues that need to be looked at, since
> 10BaseT connectivity provides VERY ERRATIC throughput, but at least it works
> now with RGMII and GMII modes.

good

> There was a lot more in my patch, but I removed a lot of the code for
> submission. Let me know if for any reason this patch file is improperly
> formatted.

It needs to be sent to the netdev mailing list, and see if you can get
rid of the MIME-encoding (see linux-2.6/Documentation/email-clients.txt).

And don't forget to add a signed-off-by line, too.

Kim
