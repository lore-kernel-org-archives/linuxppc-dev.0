Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7A0EDDDED5
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2009 00:27:48 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n1NDPYsB004652
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 08:25:34 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n1NDRi2V173566
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 08:27:44 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n1NDRhMI007528
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 08:27:44 -0500
Subject: Re: [PATCH 1/2] Deindentify identify_cpu()
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <689159d7e17a2227e6000b51911750503eed1778.1235355941.git.michael@ellerman.id.au>
References: <689159d7e17a2227e6000b51911750503eed1778.1235355941.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Mon, 23 Feb 2009 07:27:40 -0600
Message-Id: <1235395660.11996.0.camel@norville.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-02-23 at 13:25 +1100, Michael Ellerman wrote:
> The for-loop body of identify_cpu() has gotten a little big, so move the
> loop body logic into a separate function. No other changes.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Looks good to me.

Acked-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>

-- 
David Kleikamp
IBM Linux Technology Center
