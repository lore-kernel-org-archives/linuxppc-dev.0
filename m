Return-Path: <dgibson@ozlabs.org>
Date: Wed, 16 May 2007 13:26:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-dev@ozlabs.org
Subject: New version of the device tree aware EMAC driver
Message-ID: <20070516032630.GC19127@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've made a few more tiny tweaks to BenH's rewritten device-tree based
4xx EMAC driver.  The main change is that it now no longer requires
'device_type', just 'compatible' to be set in the ZMII and MAL device
nodes when probing.  This works better with current thinking on
flattened device trees which discourages creating new device_type
values unless there is a clear use for a new device class binding.

The patch can be obtained from:

http://ozlabs.org/~dgibson/home/emac/powerpc-emac-new-20070516.patch

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
