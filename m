Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: libfdt: Consistently use big-endian property data in testcases 
In-Reply-To: Your message of "Mon, 17 Sep 2007 15:42:36 +1000."
	<20070917054236.GA9303@localhost.localdomain>
References: <20070917054236.GA9303@localhost.localdomain> 
Date: Mon, 17 Sep 2007 14:24:25 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IXMCn-0002md-8u@jdl.com>
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
> Flat device trees always have integers in their structure stored as
> big-endian.  From this point of view, property values are
> bags-of-bytes and any endianness is up to users of the device tree to
> determine.
> 
> The libfdt testcases which use properties with integer values,
> currently use native endian format for the architecture on which the
> testcases are run.  This works ok for now, since both the creation and
> checking of the example device trees happen in the same endianness.
> 
> This will become a problem, however, for tests of dtc which we want to
> add in the nearish future.  dtc always uses big-endian format for
> 'cell' format data in properties; as it needs to in order to produce
> powerpc-usable device trees when hosted on a little-endian
> architecture.
> 
> This patch, therefore, changes the libfdt testsuite to use big-endian
> format always for integer format data, in order to interoperate sanely
> with future dtc testcases.  This also means that the example trees
> created by the testsuite should now be byte-for-byte identical
> regardless of dtc and libfdt's host platform, which is arguably an
> advantage.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
