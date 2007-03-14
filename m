Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from AGRXSUSMAILB.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id 4F727DDD08
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 08:11:17 +1100 (EST)
Message-ID: <45F864E8.40501@smiths-aerospace.com>
Date: Wed, 14 Mar 2007 17:11:04 -0400
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [dtc] Add support for flat device tree format version 17
References: <20070313062240.GA22737@localhost.localdomain>
	<45F863DF.5050709@freescale.com>
In-Reply-To: <45F863DF.5050709@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> David Gibson wrote:
>> libfdt defined a new version of the flattened device tree format,
>> version 17.  It is backwards compatible with version 16, just adding
>> an extra header field giving the size of the blob's structure blob.
> 
> Question:
> 
> Since the DTB is compatible with V16, then technically U-Boot can work with it.  What 
> would happen if U-Boot added some nodes to the DTB, but it didn't update size_dt_struct? 
> Would the value of size_dt_struct still be correct?  If not, then does that mean that 
> U-Boot should reject V17 DTBs?

Ahh, now I see your concern and don't know the answer at this point.

The best solution, which I'm making progress on but slowly, is to pull 
David Gibson's libfdt utilities into u-boot and use them to manipulate 
the tree.  I very much want v17 blobs because that removes my 
"write-in-place" restrictions on changing the properties.

gvb
