Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40709251546p725e66dcsbc0483cadb3ec3fb@mail.gmail.com>
Date: Tue, 25 Sep 2007 16:46:17 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: linuxppc-dev@ozlabs.com, "Paul Mackerras" <paulus@samba.org>,
	"Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Subject: Build failure on treeboot-walnut.c
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Building Paul's current powerpc branch with a ppc6xx compiler causes
the following build failure:

  SYSMAP  System.map
  BOOTCC  arch/powerpc/boot/treeboot-walnut.o
{standard input}: Assembler messages:
{standard input}:184: Error: Unrecognized opcode: `mfdcr'
{standard input}:185: Error: Unrecognized opcode: `mfdcr'
{standard input}:186: Error: Unrecognized opcode: `mfdcr'
{standard input}:217: Error: Unrecognized opcode: `mtdcr'
make[1]: *** [arch/powerpc/boot/treeboot-walnut.o] Error 1
make: *** [uImage] Error 2

This is using ELDK 4.1:
GNU assembler version 2.16.1 (powerpc-linux) using BFD version 2.16.1
gcc version 4.0.0 (DENX ELDK 4.1 4.0.0)

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
