Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8C6F267A6E
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Jan 2005 17:55:47 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jerome Glisse <j.glisse@free.fr>
In-Reply-To: <41DFC28F.1000002@free.fr>
References: <41DEA9D8.3000506@nortelnetworks.com> <41DFC28F.1000002@free.fr>
Content-Type: text/plain
Date: Mon, 17 Jan 2005 17:55:31 +1100
Message-Id: <1105944931.4533.6.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: G5 noisier under linux than firmware or OSX
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2005-01-08 at 12:22 +0100, Jerome Glisse wrote:

> 
>  From my memory, there have been some guess on values for
> therm regulation as Apple seems to not give informations or
> source code on that. Thus the values for regulating the fan are not
> the same as OS X.
> 
> By the way, i also hear little more noise. The question is : Should
> we lower the speed or stay with this conservative values ? :)

On G5s where thermal control is supported, the values are exactly the
same except for the fan of the slots bay.

Ben.
