Return-Path: <linas@austin.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7F194679F9
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2006 05:43:18 +1100 (EST)
Received: from e6.ny.us.ibm.com ([192.168.1.106])
	by pokfb.esmtp.ibm.com (8.12.11/8.12.11) with ESMTP id k1RHRCcl006435
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Feb 2006 12:27:12 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k1RHR434030065
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Feb 2006 12:27:05 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k1RHR4rB123736
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Feb 2006 12:27:04 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k1RHR4rM018652
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Feb 2006 12:27:04 -0500
Date: Mon, 27 Feb 2006 11:27:03 -0600
To: Olaf Hering <olh@suse.de>
Subject: Re: fix NULL pointer in handle_eeh_events
Message-ID: <20060227172703.GL26339@austin.ibm.com>
References: <20060227145259.GA15955@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060227145259.GA15955@suse.de>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 27, 2006 at 03:52:59PM +0100, Olaf Hering was heard to remark:
> 
> This patch fixes a crash in handle_eeh_events,

Dohh.

Acked-by: Linas Vepstas <linas@austin.ibm.com>

> but ethtool -t still doesnt work right.

I'll look at this.

--linas
