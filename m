Return-Path: <dgibson@ozlabs.org>
Date: Fri, 15 Aug 2008 10:29:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH V2] DTC: Remove support for the legacy DTS source file
	format.
Message-ID: <20080815002936.GA9877@yookeroo.seuss>
References: <E1KTlq7-0005Gh-Co@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1KTlq7-0005Gh-Co@jdl.com>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 14, 2008 at 06:02:43PM -0500, Jon Loeliger wrote:
> Now that all in-kernel-tree DTS files are properly /dts-v1/,
> remove direct support for the older, un-numbered DTS
> source file format.

Um.. why?  I just don't see a compelling reason to remove this
backwards compatibility.  It costs us very little to keep it around
indefinitely.

> Convert existing tests to /dts-v1/ and remove support
> for the conversion tests themselves.
> 
> For now, though, the conversion tool still exists.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
