Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [0/14] Ebony support, 2nd spi
Date: Tue, 20 Feb 2007 16:07:32 +0100
References: <20070220020837.GF17818@localhost.localdomain>
	<1171982767.24204.70.camel@zod.rchland.ibm.com>
	<1171983806.24204.79.camel@zod.rchland.ibm.com>
In-Reply-To: <1171983806.24204.79.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200702201607.33249.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Christian Rund <Christian.Rund@de.ibm.com>,
	Hartmut Penner <HPENNER@de.ibm.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 20 February 2007 16:03, Josh Boyer wrote:
> And the ebony dts also has the a bus type of "ibm,opb" as well.

We should really get a common name for these. I don't remember
what the discussions were, but it seems we came up with different
results for Axon and ppc4xx, which is very bad.

Using type "ibm,opb" rather than just "opb" makes sense to me,
but I don't know if we already have shipping systems that use
"opb" here.

There is probably a similar problem with the nodes for "plb4",
"plb5" and "ebc", as well as the "compatible" property of the
serial port, which, as you noted earlier is "ns16550" on 
ebony and "ns16750" on axon, although it is exactly the same
macro.

	Arnd <><
