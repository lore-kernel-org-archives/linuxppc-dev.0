Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BB59467BF2
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 09:51:23 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kB6MpKES024906
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 17:51:20 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kB6MpKP5294690
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 17:51:20 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kB6MpJxd018992
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 17:51:20 -0500
Date: Wed, 6 Dec 2006 16:51:18 -0600
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 1/5] Move rtas_stop_self() into
	platforms/pseries/hotplug-cpu.c
Message-ID: <20061206225118.GI17931@austin.ibm.com>
References: <1165301556.843426.760217571714.qpush@cradle>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1165301556.843426.760217571714.qpush@cradle>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 05, 2006 at 05:52:36PM +1100, Michael Ellerman wrote:
> As the first step in consolidating the pseries hotplug cpu code,
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

As per previous discussion,

Acked-by: Linas Vepstas <linas@austin.ibm.cm>

--linas
