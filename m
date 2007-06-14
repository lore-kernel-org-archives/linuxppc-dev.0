Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B6C6DDDED2
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 17:33:18 +1000 (EST)
In-Reply-To: <1181774801.14818.343.camel@localhost.localdomain>
References: <20070612181825.730300780@am.sony.com> >
	<466EEC01.6080807@am.sony.com>
	<f7c4ca74d3e2031e01264f31f09e515a@kernel.crashing.org>
	<20070613084023.GA28629@aepfle.de>
	<46702AFE.8080800@am.sony.com> <20070613181854.GA723@aepfle.de>
	<1181774801.14818.343.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <590cd31b74053f7499c1f53a29639175@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 29/30] PS3: Device tree source.
Date: Thu, 14 Jun 2007 09:32:55 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> No name for the root of the DT.

See my previous mail.

> IMHO, model can be whatever he wants, I would say SonyPS3-XX or
> something like that, whatever, doens't matter, the most precise the
> better.

It should be the model number of the machine.

> Then you want compatible which is the really important one. sony,ps3
> looks good to me for that, though you could have a list if you wanted.

"compatible" is only needed if your "name" is bogus, or your
machine _actually_ is 100% compatible to some other machine.


Segher
