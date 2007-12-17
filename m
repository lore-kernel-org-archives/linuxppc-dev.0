Return-Path: <SRS0+7029bc2f89979bbb0b42+1576+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Subject: Re: [PATCH] drivers/net/: Spelling fixes
From: David Woodhouse <dwmw2@infradead.org>
To: Joe Perches <joe@perches.com>
In-Reply-To: <5703e57f925f31fc0eb38873bd7f10fc44f99cb4.1197918891.git.joe@perches.com>
References: <5703e57f925f31fc0eb38873bd7f10fc44f99cb4.1197918891.git.joe@perches.com>
Content-Type: text/plain
Date: Mon, 17 Dec 2007 16:15:52 -0500
Message-Id: <1197926152.3798.263.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: Pavel Roskin <proski@gnu.org>, David Gibson <hermes@gibson.dropbear.id.au>,
	orinoco-devel@lists.sourceforge.net, Yi Zhu <yi.zhu@intel.com>,
	Jaroslav Kysela <perex@perex.cz>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Peter De Shrijver <p2@ace.ulyssis.student.kuleuven.ac.be>,
	Rastapur Santosh <santosh.rastapur@neterion.com>,
	bonding-devel@lists.sourceforge.net, Andy Gospodarek <andy@greyhouse.net>,
	"Amit S. Kale" <amitkale@netxen.com>, ipw2100-devel@lists.sourceforge.net,
	atl1-devel@lists.sourceforge.net, Chris Snook <csnook@redhat.com>,
	libertas-dev@lists.infradead.org, Dan Williams <dcbw@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Manish Lachwani <mlachwani@mvista.com>, Jean Tourrilhes <jt@hpl.hp.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Daniel Drake <dsd@gentoo.org>, Li Yang <leoli@freescale.com>,
	Jeff Garzik <jgarzik@pobox.com>, Jeb Cramer <cramerj@intel.com>,
	Chad Tindel <ctindel@users.sourceforge.net>,
	orinoco-users@lists.sourceforge.net, Jay Cliburn <jcliburn@gmail.com>,
	Samuel Ortiz <samuel@sortiz.org>,
	Sivakumar Subramani <sivakumar.subramani@neterion.com>,
	Jesse Huang <jesse@icplus.com.tw>, Mike Phillips <mikep@linuxtr.net>,
	rt2400-devel@lists.sourceforge.net, Ulrich Kunitz <kune@deine-taler.de>,
	ipw3945-devel@lists.sourceforge.net, cbe-oss-dev@ozlabs.org,
	Alexander Indenbaum <baum@tehutinetworks.net>,
	Adam Fritzler <mid@auk.cx>, Auke Kok <auke-jan.h.kok@intel.com>,
	James Ketrenos <jketreno@linux.intel.com>,
	Stefano Brivio <stefano.brivio@polimi.it>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	tulip-users@lists.sourceforge.net, netdev@vger.kernel.org,
	Ramkrishna Vepa <ram.vepa@neterion.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Corey Thomas <corey@world.std.com>, e1000-devel@lists.sourceforge.net,
	John Ronciak <john.ronciak@intel.com>, linux-ppp@vger.kernel.org,
	Ron Mercer <linux-driver@qlogic.com>,
	Sreenivasa Honnur <sreenivasa.honnur@neterion.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sorbica Shieh <sorbica@icplus.com.tw>,
	Larry Finger <Larry.Finger@lwfinger.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-12-17 at 11:40 -0800, Joe Perches wrote:
>  drivers/net/wireless/libertas/cmd.c            |    4 ++--
>  drivers/net/wireless/libertas/scan.c           |    4 ++--

I will apply these to the libertas tree; please remove them from any
resend of this patch.

If we were using git properly, it wouldn't matter -- I could just let
the patch go in upstream and when it gets merged, it'll be fine. But for
some reason we don't use git for network driver development; we pretend
it's the 1990s and we deal with sets of patches instead. So having this
simple change applied in an upstream tree would cause lots of pain, as
far as I can tell.

-- 
dwmw2
