Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0813DDDEBF
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 08:44:23 +1000 (EST)
Subject: Re: [patch 29/30] PS3: Device tree source.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <46702AFE.8080800@am.sony.com>
References: <20070612181825.730300780@am.sony.com> >
	<466EEC01.6080807@am.sony.com>
	<f7c4ca74d3e2031e01264f31f09e515a@kernel.crashing.org>
	<20070613084023.GA28629@aepfle.de>  <46702AFE.8080800@am.sony.com>
Content-Type: text/plain
Date: Thu, 14 Jun 2007 08:44:13 +1000
Message-Id: <1181774653.14818.339.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-06-13 at 10:35 -0700, Geoff Levand wrote:
> 
> I specifically changed this because this kernel is
> NOT compatible with the device tree of the legacy
> kernel (2.6.16) that used PS3PF.
> 
> If this was set as PS3PF, then there would be no
> way to tell that an incompatible DT has been passed.

No way ? heh, there are ways, you can test for a version property for
example that you add in the new one, or you can use an additional
compatible entry (compatible is a list of strings).

Ben.
