Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 24569B70E9
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Jan 2011 08:43:13 +1100 (EST)
Subject: Re: 750gx cpufreq induced kernel panic in 2.6.36
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: kevin diggs <diggskevin38@gmail.com>
In-Reply-To: <AANLkTim7gDwj+xCxiiTka23eu=v7kZX+Pq=3sQ1FT49J@mail.gmail.com>
References: <AANLkTikJ8V-gQv93HBDH3=4o51vY5xyxQojqEV7DqNj=@mail.gmail.com>
	<1296016338.2349.125.camel@pasglop>
	<AANLkTim7gDwj+xCxiiTka23eu=v7kZX+Pq=3sQ1FT49J@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 27 Jan 2011 08:43:03 +1100
Message-ID: <1296078183.2349.141.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-01-26 at 11:20 -0600, kevin diggs wrote:
> This is kind of my problem. ANY suggestions (applicable to an old
> world PowerMac) would be appreciated on how to get access to the rest
> of the information. This thing appears completely dead at this point. 

You don't have a serial port ?

If you do, use "sccdbg" on the kernel command line to route xmon to it,
and boot with console=ttyPZ0,38400 (I think the old things default to
38400 bauds). Use the "modem" port.

Cheers,
Ben.
