Return-Path: <reinette.chatre@intel.com>
Subject: Re: [Ipw2100-admin] [BUILD FAILURE 04/12] Next April 14 : PPC64
	randconfig [drivers/staging/built-in.o]
From: reinette chatre <reinette.chatre@intel.com>
To: "subrata@linux.vnet.ibm.com" <subrata@linux.vnet.ibm.com>
In-Reply-To: <1239733717.5344.76.camel@subratamodak.linux.ibm.com>
References: <1239733717.5344.76.camel@subratamodak.linux.ibm.com>
Content-Type: text/plain
Date: Tue, 14 Apr 2009 11:59:55 -0700
Message-Id: <1239735595.15115.60.camel@rc-desk>
Mime-Version: 1.0
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Greg KH <greg@kroah.com>, Andrea Merello <andreamrl@tiscali.it>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	linux-next <linux-next@vger.kernel.org>,
	Alexander Beregalov <a.beregalov@gmail.com>,
	"James P. Ketrenos" <ipw2100-admin@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Subrata,

On Tue, 2009-04-14 at 11:28 -0700, Subrata Modak wrote:
> Observed the following build error:
> ---
> LD      drivers/built-in.o
> drivers/staging/built-in.o: In function `ieee80211_xmit':
> drivers/staging/rtl8187se/ieee80211/ieee80211_tx.c:528: multiple
> definition of `ieee80211_xmit'
> drivers/net/built-in.o:drivers/net/wireless/ipw2x00/libipw_tx.c:256:
> first defined here
> make[1]: *** [drivers/built-in.o] Error 1
> make: *** [drivers] Error 2

Looks like the rtl8187se driver started with a copy of ipw2x00's
library. Errors like this can thus be expected and should be addressed
by rtl8187se as they are the ones who made the copy.

Reinette
