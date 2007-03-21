Return-Path: <dgibson@ozlabs.org>
Date: Wed, 21 Mar 2007 17:30:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: [0/4] Further zImage work
Message-ID: <20070321063031.GB30422@localhost.localdomain>
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

The following patch series is an attempt to consolidate some of the
more settled ideas in the many zImage patches flying around at the
moment.

This patch series needs to be applied on top of patches 4-7 from
Milton Miller's recent series, and patch number 2 from Scott Wood's
most recent cuboot series (patch 1 from that series having already
been applied to powerpc.git).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
