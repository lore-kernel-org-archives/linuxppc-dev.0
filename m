Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [dtc] Add support for flat device tree format version 17 
In-Reply-To: Your message of "Wed, 14 Mar 2007 11:02:40 +1100."
	<20070314000240.GD25514@localhost.localdomain>
References: <20070314000240.GD25514@localhost.localdomain> 
Date: Wed, 14 Mar 2007 15:41:48 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1HRaI8-0000P0-Gy@jdl.com>
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
> libfdt defined a new version of the flattened device tree format,
> version 17.  It is backwards compatible with version 16, just adding
> an extra header field giving the size of the blob's structure blob.
> 
> This patch adds support to dtc allowing it to read and write version
> 17 blobs.  It also makes version 17 the default output version for
> blobs.
> 
> At the same time we change the code to consistently using decimal
> numbers for versions.  Previously we sometimes used 16 and sometimes
> 0x10 to refer to version 16.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

Thanks,
jdl
