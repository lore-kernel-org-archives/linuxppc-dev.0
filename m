Return-Path: <dgibson@ozlabs.org>
Date: Wed, 31 Oct 2007 14:24:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [0/2] Embed a copy of dtc in the kernel source
Message-ID: <20071031032401.GD7772@localhost.localdomain>
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

These two patches are a respin of my previous patch to merge a copy of
dtc into the kernel tree, so that kernel builds no longer depend on an
externally installed copy of dtc.

This respin embeds a newer revision of dtc, and incorporates Sam
Ravnborg's preferred approach to Makefile integration.  Also, since so
many people whinged about it last time, I've split the patch into two
parts, the first is the too-large-for-the-list patch just verbatim
adding files and the second has the changes to existing kernel files
to build and use the embedded code.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
