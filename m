Return-Path: <arnd.bergmann@de.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A914867B7C
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 02:16:59 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7IGGtRV005510
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 12:16:55 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7IGGs6P290304
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 12:16:54 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7IGGsxu023420
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 12:16:54 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [2.6.19 PATCH 3/7] ehea: queue management
Date: Fri, 18 Aug 2006 18:16:51 +0200
References: <OFC184057C.C58732A2-ONC12571CE.004E5EF6-C12571CE.004ED1D4@de.ibm.com>
In-Reply-To: <OFC184057C.C58732A2-ONC12571CE.004E5EF6-C12571CE.004ED1D4@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608181816.52079.arnd.bergmann@de.ibm.com>
Cc: Thomas Q Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <RAISCH@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, tklein@linux.ibm.com,
	abergman@de.ibm.com, Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 18 August 2006 16:24, Christoph Raisch wrote:
> And as always in performance tuning... one size fits all unfortunately is
> not the correct answer.

Ah, good. What is the maximum sensible value that you came up with?

> Therefore we'll leave that open to the user as most other new ethernet
> driver did as well.

Sure. The interesting question is whether you want to allow users
to set it to a value that is no longer sensible to do with
__get_free_pages() and requires vmalloc().

	Arnd <><
