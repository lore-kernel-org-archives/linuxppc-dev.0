Return-Path: <davej@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 63AE7DDF52
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 04:04:51 +1100 (EST)
Date: Wed, 12 Dec 2007 12:04:40 -0500
From: Dave Jones <davej@redhat.com>
To: Thomas Klein <osstklei@de.ibm.com>
Subject: Re: [RFC] ehea: kdump support using new shutdown hook
Message-ID: <20071212170440.GD2359@redhat.com>
References: <200712121753.43543.osstklei@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200712121753.43543.osstklei@de.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Marcus Eder <meder@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 12, 2007 at 05:53:43PM +0100, Thomas Klein wrote:

 > +static void ehea_update_adapter_handles(struct ehea_adapter *adapter)
 > +{
 > +	int i, k;
 > +	int j = 0;
 > +
 > +	memset(adapter->res_handles, sizeof(adapter->res_handles), 0);

arguments wrong way around.
 
	Dave
 
-- 
http://www.codemonkey.org.uk
