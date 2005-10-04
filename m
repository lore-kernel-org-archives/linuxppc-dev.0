Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 605FB683A8
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Oct 2005 08:10:34 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marc <marvin24@gmx.de>
In-Reply-To: <200510040814.07188.marvin24@gmx.de>
References: <DCEAAC0833DD314AB0B58112AD99B93B859476@ismail.innsys.innovsys.com>
	<200510040814.07188.marvin24@gmx.de>
Content-Type: text/plain
Date: Wed, 05 Oct 2005 08:10:19 +1000
Message-Id: <1128463821.6417.27.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: clock skew on B/W G3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-10-04 at 08:14 +0200, Marc wrote:
> Hi,
> 
> given that this option causes problems on non i386 systems, may I propose to 
> mark CONFIG_HZ as broken on these architectures and/or use a default value of 
> 1000 ? I guess this issue can't be fixed in a sane way until 2.6.14 is out.

No, it should work fine, there is something else broken on this G3

Ben.
