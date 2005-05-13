Return-Path: <markc@mail.com>
Received: from relay03.roc.ny.frontiernet.net (relay03.roc.ny.frontiernet.net
	[66.133.182.166]) by ozlabs.org (Postfix) with ESMTP id 5C4BF679F4
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 May 2005 23:14:36 +1000 (EST)
Message-ID: <005b01c557bd$c04e2770$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Pantelis Antoniou" <panto@intracom.gr>
References: <200505131433.23307.Schramel.Linux@go.bartec.de>
	<4284A19A.7010901@intracom.gr>
Date: Fri, 13 May 2005 09:14:47 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: PPC_LINUX <linuxppc-embedded@ozlabs.org>
Subject: Re: insmod problem
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
>
> You're using floating arithmetic in the kernel.
>
> That's not supported.
>
> Regards
>
> Pantelis
>

Just for my edification:  Is floating point itself not supported (floating
point register
corruption or something like that) or just linking to user space libraries?

Mark Chambers
