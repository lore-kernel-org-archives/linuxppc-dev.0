Return-Path: <WALD@de.ibm.com>
In-Reply-To: <1214434596.8011.425.camel@pasglop>
Subject: Re: [Cbe-oss-dev] 2.6.26-rc6 kernel bug on PS3?
To: benh@kernel.crashing.org
Message-ID: <OF8B36A4C1.D38C72A9-ONC1257474.002263DB-C1257474.0022969B@de.ibm.com>
From: Stefan Wald <WALD@de.ibm.com>
Date: Thu, 26 Jun 2008 08:17:47 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Jeremy Kerr <jk@ozlabs.org>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, cbe-oss-dev-bounces+wald=de.ibm.com@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

cbe-oss-dev-bounces+wald=de.ibm.com@ozlabs.org wrote on 06/26/2008 12:56:36
AM:

>
> > With 2.6.24 (your version from early february) the PS3 hangs
completely...
> > you have to power cycle the ps3.
> > so, it looks like 2.6.26 is a little better... but you have to power
off/on
> > as well to get rid of the zombie.
>
> Looks like an issue with spufs. Though from your traces, it looks like
> it's something that happens when apps quit.
>
> Does your workload involves SPU apps quitting regulary ?

Yes, we have about 10 demos that we run in a loop from a script.
Stefan
