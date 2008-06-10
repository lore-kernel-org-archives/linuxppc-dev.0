Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18510.26952.733823.290697@cargo.ozlabs.ibm.com>
Date: Tue, 10 Jun 2008 21:45:12 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Master and powerpc-next branches reset
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Due to the "Free a PTE bit on ppc64 with 64K pages" commit from Ben H
turning out to be bad, I have reset the master and powerpc-next
branches of the powerpc.git repository to the commit just before that,
and then reapplied the "powerpc: Remove arch/ppc and include/asm-ppc"
commit (taking the opportunity to add John Linn's acked-by).

So if you pull either or both of those branches, you'll need to do a
git pull -f next time.  I prefer not to reset branches if possible,
but it seemed necessary to remove the bad commit in this case so as
not to cause bisection problems later.

Paul.
