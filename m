Return-Path: <arnd.bergmann@de.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1BD3B67B7E
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 02:21:57 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7IGLpmo007845
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 12:21:51 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7IGLp2P267114
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 12:21:51 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7IGLoPK007126
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 12:21:51 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 02/13] IB/ehca: includes
Date: Fri, 18 Aug 2006 18:21:49 +0200
References: <OFED0915E4.3CED6795-ONC12571CE.0053ECB8-C12571CE.0055546A@de.ibm.com>
In-Reply-To: <OFED0915E4.3CED6795-ONC12571CE.0053ECB8-C12571CE.0055546A@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608181821.49961.arnd.bergmann@de.ibm.com>
Cc: Christoph Raisch <RAISCH@de.ibm.com>, Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>,
	linux-kernel@vger.kernel.org, openib-general@openib.org,
	Marcus Eder <MEDER@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 18 August 2006 17:35, Christoph Raisch wrote:
> we'll change these EDEBs to a wrapper around dev_err, dev_dbg and dev_warn
> as it's done in the mthca driver.
>
> ...
>
> Hope that's the "official" way how to implement it in ib drivers.

I guess it would be even better to just use the dev_* macros directly
instead of having your own wrapper. You can do that in both ehca and ehea.

	Arnd <><
