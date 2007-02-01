Return-Path: <jens@de.ibm.com>
From: Jens Osterkamp <jens@de.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: spidernet: dynamic phy setup code
Date: Thu, 1 Feb 2007 11:50:51 +0100
References: <200701261409.29537.jens@de.ibm.com>
	<1169842902.24996.108.camel@localhost.localdomain>
In-Reply-To: <1169842902.24996.108.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200702011150.52199.jens@de.ibm.com>
Cc: netdev@vger.kernel.org, James K Lewis <jim@jklewis.com>,
	linuxppc-dev@ozlabs.org, jgarzik@pobox.com, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 26 January 2007 9:21 pm, Benjamin Herrenschmidt wrote:

> Can't we have a device-tree property indicating wether to use fiber or
> copper ?

Well, yes, I am sure we could, but what would be the benefit of doing so
if we can get the same information dynamically ?

Jens
