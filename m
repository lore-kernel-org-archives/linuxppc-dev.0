Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18602.18568.338552.482669@cargo.ozlabs.ibm.com>
Date: Tue, 19 Aug 2008 14:14:00 +1000
From: Paul Mackerras <paulus@samba.org>
To: Joachim Fenkes <fenkes@de.ibm.com>
Subject: Re: [PATCH] ibmebus/of_platform: Move "name" sysfs attribute into
	generic OF devices
In-Reply-To: <200808051630.19619.fenkes@de.ibm.com>
References: <200808051630.19619.fenkes@de.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Olaf Hering <olaf@aepfle.de>,
	Paul Mackerras <pmac@au1.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	Alexander Schmidt <alexschm@de.ibm.com>,
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

> Recent of_platform changes made of_bus_type_init() overwrite the bus type's
> .dev_attrs list, so move ibmebus' "name" attribute (which is needed by eHCA
> userspace support) into generic OF device code. Tested on POWER.

Is this a bugfix that is needed for 2.6.27?
