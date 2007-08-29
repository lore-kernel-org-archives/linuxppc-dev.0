Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id 45496DDE2F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Aug 2007 19:28:38 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: ppc_8xx-gcc from eldk strange behaviour
Date: Wed, 29 Aug 2007 11:28:36 +0200
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8EA185B5@aquib01a>
In-Reply-To: <20070828190158.GA21155@ld0162-tx32.am.freescale.net>
From: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
To: "Scott Wood" <scottwood@freescale.com>
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

> C does not specify the signedness of char.  If you care, you need to
> explicitly specify.

Sorry, I didn't know this. Anyway I would expect the same behaviour from
both host gcc and ppc_8xx-gcc. In this case host gcc is wrong.=20

Bye,
Antonio.
