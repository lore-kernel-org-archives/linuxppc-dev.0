Return-Path: <buytenh@wantstofly.org>
Received: from xi.wantstofly.org (xi.wantstofly.org [83.160.184.112])
	by ozlabs.org (Postfix) with ESMTP id 4D484DDF49
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Aug 2008 23:06:42 +1000 (EST)
Date: Mon, 4 Aug 2008 14:42:29 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: linuxppc-dev@ozlabs.org
Subject: mv643xx_eth changes for 2.6.27
Message-ID: <20080804124229.GB31974@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The mv643xx_eth ethernet driver has had some very heavy hacking done
to it during the 2.6.27 merge window:

$ wc -l linux-2.6.26/drivers/net/mv643xx_eth.c linux-2.6.27-rc1-git4/drivers/net/mv643xx_eth.c 
  3365 linux-2.6.26/drivers/net/mv643xx_eth.c
  2653 linux-2.6.27-rc1-git4/drivers/net/mv643xx_eth.c
$ diff -u linux-2.6.26/drivers/net/mv643xx_eth.c linux-2.6.27-rc1-git4/drivers/net/mv643xx_eth.c
 mv643xx_eth.c | 4774 ++++++++++++++++++++++++----------------------------------
 1 file changed, 2031 insertions(+), 2743 deletions(-)
$

If you have any Linux-running device that has an mv643xx_eth in it (i.e.
if it has a Marvell Discovery controller or a Marvell ARM SoC in it),
please test 2.6.27-rc2 extensively (once it is released) and report
whether it works for you or not.  IOW, please send me success reports
as well as failure reports.

Thanks.
