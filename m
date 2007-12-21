Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A2573DDE1B
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 04:21:22 +1100 (EST)
Received: from [192.168.12.21] (unknown [10.149.0.1])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id E88F98810
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 22:21:18 +0400 (SAMT)
Message-ID: <476BF5B7.3030201@ru.mvista.com>
Date: Fri, 21 Dec 2007 20:19:51 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/4] PowerPC: Add PCI node to 440GRx Rainier DTS.
References: <20071221162708.GA1724@ru.mvista.com>
In-Reply-To: <20071221162708.GA1724@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +			reg = <1 eec00000 8	/* Config space access */
> +			       1 eed80000 4	/* IACK */
> +			       1 eed80000 4	/* Special cycle */

Please, discard this one, since it contains the typos pasted from 
previous bamboo dts, which have been fixed :).

I'll send the corrected patch right away.
Thanks,
Valentine.
