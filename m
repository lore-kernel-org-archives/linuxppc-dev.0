Return-Path: <dgibson@ozlabs.org>
Date: Wed, 7 Feb 2007 15:46:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [dtc] Allow multipart property values
Message-ID: <20070207044616.GF23870@localhost.localdomain>
References: <20070207032343.GD23870@localhost.localdomain>
	<41B393C3-9A8F-46EC-9B47-FCF8E0733994@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41B393C3-9A8F-46EC-9B47-FCF8E0733994@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 06, 2007 at 10:37:25PM -0600, Kumar Gala wrote:
> 
> On Feb 6, 2007, at 9:23 PM, David Gibson wrote:
> 
> > At present each property definition in a dts file must give as the
> > value either a string ("abc..."), a bytestring ([12abcd...]) or a cell
> > list (<1 2 3 ...>).  This patch allows a property value to be given as
> > several of these, comma-separated.  The final property value is just
> > the components appended together.  So a property could have a list of
> > cells followed by a string, or a bytestring followed by some cells.
> > Cells are always aligned, so if cells are given following a string or
> > bytestring which is not a multiple of 4 bytes long, zero bytes are
> > inserted to align the following cells.
> >
> > The primary motivation for this feature, however, is to allow defining
> > a property as a list of several strings.  This is what's needed for
> > defining OF 'compatible' properties, and is less ugly and fiddly than
> > using embedded \0s in the strings.
> >
> > Signed-off-by: David Gibson <dwg@au1.ibm.com>
> 
> Mind adding examples to the testsuite?

What testsuite...?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
