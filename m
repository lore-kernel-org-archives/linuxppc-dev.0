Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18603.22359.447836.113347@cargo.ozlabs.ibm.com>
Date: Wed, 20 Aug 2008 09:29:27 +1000
From: Paul Mackerras <paulus@samba.org>
To: Joachim Fenkes <FENKES@de.ibm.com>
Subject: Re: [PATCH] ibmebus/of_platform: Move "name" sysfs attribute into
	generic OF devices
In-Reply-To: <OFD6515867.CFE29C04-ONC12574AA.003B8D55-C12574AA.003BB443@de.ibm.com>
References: <200808051630.19619.fenkes@de.ibm.com>
	<18602.18568.338552.482669@cargo.ozlabs.ibm.com>
	<OFD6515867.CFE29C04-ONC12574AA.003B8D55-C12574AA.003BB443@de.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Olaf Hering <olaf@aepfle.de>,
	Paul Mackerras <pmac@au1.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>,
	Alexander Schmidt1 <ALEXSCHM@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Joachim Fenkes writes:

> > Is this a bugfix that is needed for 2.6.27?
> 
> Yes, definitely. The eHCA userspace driver relies on the name attribute to 
> check for valid adapters (it checks that the name is "lhca"), so with the 
> name attribute gone, eHCA userspace will cease to work.

OK, I'll put it in.  Please, in future, always say explicitly if you
think a patch needs to go in to the kernel we're currently
stablizing.  Otherwise, I'll generally assume it's for the next merge
window.

Paul.
