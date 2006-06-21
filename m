Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [patch 01/20] cell: add RAS support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20060620154304.GD4845@pb15.lixom.net>
References: <20060619183315.653672000@klappe.arndb.de>
	<20060619183404.144740000@klappe.arndb.de>
	<20060620154304.GD4845@pb15.lixom.net>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 11:46:25 +1000
Message-Id: <1150854385.12507.59.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org, arnd@arndb.de,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-06-20 at 10:43 -0500, Olof Johansson wrote:
> On Mon, Jun 19, 2006 at 08:33:16PM +0200, arnd@arndb.de wrote:
> > From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > 
> > This is a first version of support for the Cell BE "Reliability,
> > Availability and Serviceability" features.
> 
> Does it really make sense to do this under a config option? I don't see
> why anyone would not want to know that their machine is about to melt.

Well, it's not quite clear yet wether that thing works at all at this
point :) It shuld be a config option (becasue those things don't make
sense on LPAR cells) but maybe not a selectable one ...

Ben.
