Return-Path: <markc@mail.com>
Received: from relay01.roc.ny.frontiernet.net (relay01.roc.ny.frontiernet.net
	[66.133.182.164]) by ozlabs.org (Postfix) with ESMTP id 45F0C68596
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Nov 2005 01:02:59 +1100 (EST)
Message-ID: <004001c5e07f$b1cfef30$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Clemens Koller" <clemens.koller@anagramm.de>,
	"Absolut Hunter" <absoluthunter@comcast.net>
References: <000901c5e017$91aef880$6405a8c0@absolut>
	<4369EDD3.1010309@anagramm.de>
Date: Thu, 3 Nov 2005 09:05:31 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: SM501 Frame Buffer driver on PPC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> The endianess on PCI on ppc is still an issue (I haven't investigated this
> problem further during the last month).
> 

There really shouldn't be an endian issue on SM501 since registers are
32 bit.  What we do have is the 5200 that does byte swapping on PCI
for no good reason (IMHO)

--Mark Chambers
