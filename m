Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 22 Nov 2006 18:55:22 +1100
Subject: [PATCH 0/9] More xmon cell patches
Message-Id: <1164182122.302443.256192350213.qpush@cradle>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is an updated series of xmon cell patches, it replaces the series
of three I sent earlier (Nov 3rd).

It fixes the xmon sparse warnings, updates 'ss, adds 'sd' and 'sdi'
commands to xmon - and incorporates updated disassembly code. Finally
we make the disassembly optional for folks looking for a smaller kernel.

The update of the ppc-dis.c code is RFC, I just thought I'd do it while I
was there. But I haven't tested it thoroughly.

cheers
