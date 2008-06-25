Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] 2.6.26-rc6 kernel bug on PS3?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Wald <WALD@de.ibm.com>
In-Reply-To: <OF7F0C0F41.6CA7F070-ONC1257473.006CC318-C1257473.006D4831@de.ibm.com>
References: <OF7F0C0F41.6CA7F070-ONC1257473.006CC318-C1257473.006D4831@de.ibm.com>
Content-Type: text/plain
Date: Thu, 26 Jun 2008 08:56:36 +1000
Message-Id: <1214434596.8011.425.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Jeremy Kerr <jk@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> With 2.6.24 (your version from early february) the PS3 hangs completely...
> you have to power cycle the ps3.
> so, it looks like 2.6.26 is a little better... but you have to power off/on
> as well to get rid of the zombie.

Looks like an issue with spufs. Though from your traces, it looks like
it's something that happens when apps quit.

Does your workload involves SPU apps quitting regulary ?

Cheers,
Ben.
