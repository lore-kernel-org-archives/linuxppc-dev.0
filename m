Return-Path: <sean.hefty@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by ozlabs.org (Postfix) with ESMTP id C8350DE29B
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 09:09:25 +1100 (EST)
From: "Sean Hefty" <sean.hefty@intel.com>
To: "'Caitlin Bestler'" <Caitlin.Bestler@neterion.com>,
	"Joachim Fenkes" <FENKES@de.ibm.com>
References: <469958e00712131122s661dd970ud359389e1c6637d4@mail.gmail.com><OFD5B7D5E6.3538DC2A-ONC12573B0.0072D42A-C12573B0.00735730@de.ibm.com>
	<78C9135A3D2ECE4B8162EBDCE82CAD7702B14004@nekter>
Subject: RE: [ofa-general] Re: [ewg] Re: [PATCH] IB/ehca: SerializeHCA-related
	hCalls on POWER5
Date: Thu, 13 Dec 2007 13:48:40 -0800
Message-ID: <000301c83dd1$ec49d520$9b37170a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <78C9135A3D2ECE4B8162EBDCE82CAD7702B14004@nekter>
Cc: Arnd Bergmann <arnd@arndb.de>, Roland Dreier <rdreier@cisco.com>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
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

>To clarify, an FMR Work Request is simply posted to the SendQ like
>any other Work Request (of course the QP has to be privileged, or
>it will complete in error). An SQ Post should never block.

FMR's as defined by the IB spec and that created by Mellanox are not the same.
They, unfortunately, use the same name and acronym only.  Mellanox FMRs use an
API that is more like that of standard MRs. 

- Sean
