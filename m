Return-Path: <olof@lixom.net>
Date: Tue, 20 Jun 2006 10:43:04 -0500
To: arnd@arndb.de
Subject: Re: [Cbe-oss-dev] [patch 01/20] cell: add RAS support
Message-ID: <20060620154304.GD4845@pb15.lixom.net>
References: <20060619183315.653672000@klappe.arndb.de>
	<20060619183404.144740000@klappe.arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060619183404.144740000@klappe.arndb.de>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, cbe-oss-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 19, 2006 at 08:33:16PM +0200, arnd@arndb.de wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> This is a first version of support for the Cell BE "Reliability,
> Availability and Serviceability" features.

Does it really make sense to do this under a config option? I don't see
why anyone would not want to know that their machine is about to melt.


-Olof
