Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [dtc] Allow multipart property values 
In-Reply-To: Your message of "Wed, 07 Feb 2007 16:37:50 +1100."
	<20070207053750.GG23870@localhost.localdomain>
References: <20070207032343.GD23870@localhost.localdomain>
	<41B393C3-9A8F-46EC-9B47-FCF8E0733994@kernel.crashing.org>
	<20070207044616.GF23870@localhost.localdomain>
	<BDAF32A9-05AE-4AFA-922B-22752C3B0845@kernel.crashing.org>
	<20070207053750.GG23870@localhost.localdomain>
Date: Thu, 08 Feb 2007 17:29:03 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1HFIhL-0003bU-UX@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> 
> There's nothing in tests/ though - I always meant to make a testsuite,
> but I never got around to it.  Current plan is to implement a
> testsuite by merging libfdt into the dtc tree.
> 
> Here's a revised patch which adds an example usage to test.dts
> 
> [dtc] Allow multipart property values
> 
> At present each property definition in a dts file must give as the
> value either a string ("abc..."), a bytestring ([12abcd...]) or a cell
> list (<1 2 3 ...>).  This patch allows a property value to be given as
> several of these, comma-separated.  The final property value is just
> the components appended together.  So a property could have a list of
> cells followed by a string, or a bytestring followed by some cells.
> Cells are always aligned, so if cells are given following a string or
> bytestring which is not a multiple of 4 bytes long, zero bytes are
> inserted to align the following cells.
> 
> The primary motivation for this feature, however, is to allow defining
> a property as a list of several strings.  This is what's needed for
> defining OF 'compatible' properties, and is less ugly and fiddly than
> using embedded \0s in the strings.
> 
> Signed-off-by: David Gibson <dwg@au1.ibm.com>

Applied.

Thanks,
jdl
