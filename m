Return-Path: <kate@katix.org>
Received: from ns.iti.fi (unknown [195.218.81.131])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8542C679EA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Feb 2006 08:51:56 +1100 (EST)
Message-ID: <49995.195.218.81.146.1139866274.squirrel@195.218.81.146>
In-Reply-To: <IULG07$EC9BCBEDC5067C42C017F8A6DF5C1559@libero.it>
References: <IULG07$EC9BCBEDC5067C42C017F8A6DF5C1559@libero.it>
Date: Mon, 13 Feb 2006 23:31:14 +0200 (EET)
Subject: Re: SPI Katix subsytem
From: "Kate Alhola" <kate@katix.org>
To: "dibacco\@inwind\.it" <dibacco@inwind.it>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Reply-To: kate@katix.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Hi,
>
> I would like to use a SPI subsystem on 2.4 but katix framework seems to be
> not  continuosly updated. Katix is also present in 2.6 or is there another
> more supported framework there?

I really think that i need update my SPI subsystem more frequently.
I have got wery little feedback so i have not been so active releasind
new versions. May be it is time for release my current additions.

At the moment i have drivers only for mpc5200 because it is hw that i have
use for PPC architecture.  May be i should set up public cvs so that
it will be easier to add third party SPI driver modules.

I have planning to port it for 2.6 kernel. May be it is time once
again check if the 2.6 is enough mature for 5200. Least i should
take latest snapshot from Denx and saw that there is.


Kate


> Bye,
> Antonio.
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
