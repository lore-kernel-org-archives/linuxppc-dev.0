Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0DD53B7179
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Nov 2010 10:20:07 +1100 (EST)
Message-ID: <53628.94.211.195.167.1290035996.squirrel@gate.crashing.org>
In-Reply-To: <AANLkTinWry94YidZRu_4nr1ahgPiVV06g+zh_zDF8iGQ@mail.gmail.com>
References: <AANLkTiksY8x7XOifU3FAAPpCa_h4oEBmqu_a0vjRE5h5@mail.gmail.com>
	<1289255477.2147.1368.camel@pasglop>
	<AANLkTin1wdo1e9nt07H+UkQmKWSvnKa+CHzwuQ8F2gR1@mail.gmail.com>
	<AANLkTinWry94YidZRu_4nr1ahgPiVV06g+zh_zDF8iGQ@mail.gmail.com>
Date: Thu, 18 Nov 2010 00:19:56 +0100 (CET)
Subject: Re: PowerMac8600 help ...
From: "Segher Boessenkool" <segher@kernel.crashing.org>
To: "kevin diggs" <diggskevin38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> I have also discovered what prevented
> firefox from working with 4.3.5. It was picking up the 3.4.6 libstdc++
> (possibly other internal tidbits as well).

So you installed (one of) those compilers incorrectly.

> P.S.:  newer powermacs have a line in cpuinfo, like "PowerMac 7,2".
> Does this uniquely identify a particular model?

Yes.  There's a board revision as well, but I don't think we ever
needed to use that info.


Segher
