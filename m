Return-Path: <linas@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 15987DDE33
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 02:11:44 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l49FA2WL007650
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 11:10:02 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l49GBdQQ512208
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 12:11:39 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l49GBdGY009972
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 12:11:39 -0400
Date: Wed, 9 May 2007 11:11:38 -0500
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 1/4] powerpc: EEH: log error only after driver
	notification.
Message-ID: <20070509161138.GT4452@austin.ibm.com>
References: <20070508230952.GN4452@austin.ibm.com>
	<20070508233329.GP4452@austin.ibm.com>
	<20070509045115.GA1771@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070509045115.GA1771@lixom.net>
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

On Tue, May 08, 2007 at 11:51:15PM -0500, Olof Johansson wrote:
> > +	eeh_slot_error_detail(frozen_pdn, 1 /* Temporary Error */);
> 
> I know you only moved it, but if you have to document what '1' means,
> you really should add a symbolic define/enum instead. 

Of course. Coming up.

--linas
