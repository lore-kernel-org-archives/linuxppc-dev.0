Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 7/11] ibm_newemac: Skip EMACs that are marked unused by
	the firmware
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20071205035345.GA12855@localhost.localdomain>
References: <20071205001539.97730DE091@ozlabs.org>
	<20071205035345.GA12855@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 05 Dec 2007 15:18:49 +1100
Message-Id: <1196828329.13230.356.camel@pasglop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2007-12-05 at 14:53 +1100, David Gibson wrote:
> It occurred to me the other day.  Instead of using a new "unused"
> property for this, should we be using the OF standard "status"
> property.

Dunno... it's really not wired. Probably not even clocked.

Ben.
