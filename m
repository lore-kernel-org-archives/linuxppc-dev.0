Return-Path: <ogerlitz@voltaire.com>
Received: from exil.voltaire.com (fwil.voltaire.com [193.47.165.2])
	by ozlabs.org (Postfix) with ESMTP id 5CE1EDDEA0
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 23:26:41 +1100 (EST)
Message-ID: <475FD0A1.3090304@voltaire.com>
Date: Wed, 12 Dec 2007 14:14:25 +0200
From: Or Gerlitz <ogerlitz@voltaire.com>
MIME-Version: 1.0
To: Joachim Fenkes <FENKES@de.ibm.com>
Subject: Re: [ewg] Re: [PATCH] IB/ehca: Serialize HCA-related hCalls on POWER5
References: <OFD9564F75.44193623-ONC12573AE.002EA542-C12573AE.002F5FBC@de.ibm.com>
In-Reply-To: <OFD9564F75.44193623-ONC12573AE.002EA542-C12573AE.002F5FBC@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Arnd Bergmann <arnd@arndb.de>, Roland Dreier <rdreier@cisco.com>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Christoph Raisch <raisch@de.ibm.com>,
	OF-General <general@lists.openfabrics.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Joachim Fenkes wrote:
> Roland Dreier <rdreier@cisco.com> wrote on 10.12.2007 22:47:37:

>> It's an optional device feature, so this should be OK
>> (although the iSER driver currently seems to depend on a device
>> supporting FMRs, which is probably going to be a problem with iWARP
>> support in the future anyway).

> I don't feel very well with removing code from the driver that iSER seems 
> to depend on. Are there plans to fix this in iSER?

What is the fix you suggest, to add a device query that tells you for 
which verbs the documentation does not apply? or enhance the code of the 
  map_phys_fmr verb within the ehca driver to return error if called 
from non-sleepable context?

Or.
