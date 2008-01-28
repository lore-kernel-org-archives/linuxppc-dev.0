Return-Path: <yeduj@ece.pdx.edu>
Received: from ehlo.cat.pdx.edu (ehlo.cat.pdx.edu [131.252.208.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mailhost.cecs.pdx.edu",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2611ADDD0B
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Jan 2008 15:25:11 +1100 (EST)
Message-ID: <20080127202502.zte3h0yr4s44ooc8@webmail.cecs.pdx.edu>
Date: Sun, 27 Jan 2008 20:25:02 -0800
From: Yedu Jathavedan <yeduj@ece.pdx.edu>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Load Kernel 2.6 using U-boot on ML403
References: <20080126231047.y3lm7epb0gw4cog8@webmail.cecs.pdx.edu>
	<fa686aa40801271313y4370ac3dmd4460d79362f10c4@mail.gmail.com>
In-Reply-To: <fa686aa40801271313y4370ac3dmd4460d79362f10c4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
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


>
> Looking at your bootlog, it doesn't look like you've got the systemace
> driver built into the kernel.
>
>
Grant,

Yes, the systemace was not built into the kernel. It is successfully  
booting the kernel now.
Trying to bring up the Ethernet interface. Any pointers?

Thank you,
Yedu
