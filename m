Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5665F2C0098
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2012 22:59:15 +1100 (EST)
Date: Wed, 21 Nov 2012 11:55:44 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Bill Pemberton <wfp5p@virginia.edu>
Subject: Re: [PATCH 198/493] ethernet: remove use of __devinit
Message-ID: <20121121115544.GG3290@n2100.arm.linux.org.uk>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-198-git-send-email-wfp5p@virginia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1353349642-3677-198-git-send-email-wfp5p@virginia.edu>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-mips@linux-mips.org, Chris Snook <chris.snook@gmail.com>,
 Samuel Chessman <chessman@tux.org>, David Dillow <dave@thedillows.org>,
 Jaroslav Kysela <perex@perex.cz>, Daniele Venzano <venza@brownhat.org>,
 Stephen Hemminger <shemminger@vyatta.com>, John Linn <John.Linn@xilinx.com>,
 e1000-devel@lists.sourceforge.net, Guo-Fu Tseng <cooldavid@cooldavid.org>,
 linux-acenic@sunsite.dk, cbe-oss-dev@lists.ozlabs.org,
 Francois Romieu <romieu@fr.zoreil.com>,
 Steve Glendinning <steve.glendinning@shawell.net>,
 Jes Sorensen <jes@trained-monkey.org>, Jay Cliburn <jcliburn@gmail.com>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Grant Grundler <grundler@parisc-linux.org>, Wan ZongShun <mcuos.com@gmail.com>,
 Anirudha Sarangi <anirudh@xilinx.com>, linuxppc-dev@lists.ozlabs.org,
 Don Fry <pcnet32@frontier.com>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Roger Luethi <rl@hellgate.ch>, Florian Fainelli <florian@openwrt.org>,
 linux-arm-kernel@lists.infradead.org, Mirko Lindner <mlindner@marvell.com>,
 Steffen Klassert <klassert@mathematik.tu-chemnitz.de>,
 Geoff Levand <geoff@infradead.org>, gregkh@linuxfoundation.org,
 Ralf Baechle <ralf@linux-mips.org>, Vitaly Bordug <vbordug@ru.mvista.com>,
 netdev@vger.kernel.org, Olof Johansson <olof@lixom.net>,
 uclinux-dist-devel@blackfin.uclinux.org,
 Kristoffer Glembo <kristoffer@gaisler.com>,
 Sorbica Shieh <sorbica@icplus.com.tw>, Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 19, 2012 at 01:22:27PM -0500, Bill Pemberton wrote:
>  drivers/net/ethernet/8390/etherh.c                 |  4 +-
>  drivers/net/ethernet/amd/am79c961a.c               |  2 +-
>  drivers/net/ethernet/i825xx/ether1.c               |  8 +-
>  drivers/net/ethernet/seeq/ether3.c                 | 10 +--

For these four,

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
