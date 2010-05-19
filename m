Return-Path: <khali@linux-fr.org>
Received: from bamako.nerim.net (bamako.nerim.net [62.4.17.28])
	by ozlabs.org (Postfix) with ESMTP id 00DFEB7D59
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 May 2010 23:16:31 +1000 (EST)
Date: Wed, 19 May 2010 15:16:26 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Andre Prendel <andre.prendel@gmx.de>
Subject: Re: [lm-sensors] [PATCH] hwmon: (tmp421) Add nfactor support (2nd
	attempt)
Message-ID: <20100519151626.1e1262be@hyperion.delvare>
In-Reply-To: <20100519072659.GA2069@andre-laptop>
References: <4BF1A760.2010707@theptrgroup.com>
	<20100518113838.GA2052@andre-laptop>
	<4BF2A5A9.6010907@theptrgroup.com>
	<20100519072659.GA2069@andre-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, lm-sensors@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Andre,

On Wed, 19 May 2010 09:26:59 +0200, Andre Prendel wrote:
> Jean, should we describe this interface in Documentation/hwmon/sysfs-interface
> too? For the moment tmp421 is the only driver implementing it.

If the values are expressed in a standard unit (i.e. not raw register
values) then yes, it would be nice to have a standard interface
described for these files.

-- 
Jean Delvare
