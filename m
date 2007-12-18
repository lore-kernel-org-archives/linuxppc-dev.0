Return-Path: <dgibson@ozlabs.org>
Date: Tue, 18 Dec 2007 15:03:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: [0/2] Merge dtc
Message-ID: <20071218040348.GB10348@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is a revised set of patches to merge dtc into the kernel tree.

The various methods suggested for doing some sort of automagic git
pull of the dtc repository into the kernel git all appear to me to be
more trouble than they're worth at this stage.  So, at this stage this
is just a raw patch importing the source.  I have scripts which make
it an easy job to produce a patch updating the embedded copy of dtc.

If at some future point we want to move dtc to a more general place so
it can be used by microblaze or other architectures as well, we can
revisit how the import is done at that time.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
