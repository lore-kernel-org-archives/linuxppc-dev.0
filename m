Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: galak@kernel.crashing.org, Becky Bruce <beckyb@kernel.crashing.org>
MIME-Version: 1.0
Subject: Build fail in hugetlbpage.c with linux-next and mpc85xx_defconfig
Date: Thu, 16 Feb 2012 10:08:41 +1100
Message-ID: <14174.1329347321@neuling.org>
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Becky,

This has been broken in linux-next for a while.  Looks like a merge
issue but you were the last to touch it...

arch/powerpc/mm/hugetlbpage.c: In function 'reserve_hugetlb_gpages':
arch/powerpc/mm/hugetlbpage.c:313: error: passing argument 5 of 'parse_args' makes integer from pointer without a cast
include/linux/moduleparam.h:317: note: expected 's16' but argument is of type 'int (*)(char *, char *)'
arch/powerpc/mm/hugetlbpage.c:313: error: too few arguments to function 'parse_args'

Mikey
