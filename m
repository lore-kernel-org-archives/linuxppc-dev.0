Return-Path: <mkravetz@us.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F1EAA67B92
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 12:32:59 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7F2WqaJ019389
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 22:32:52 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7F2Wp2q280632
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 22:32:51 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7F2WpJE012715
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 22:32:51 -0400
Date: Mon, 14 Aug 2006 19:34:02 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH] powerpc: Instrument Hypervisor Calls
Message-ID: <20060815023402.GB3622@monkey.ibm.com>
References: <20060814234146.GA17027@w-mikek2.ibm.com>
	<44E12B03.6020503@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <44E12B03.6020503@am.sony.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 14, 2006 at 07:01:39PM -0700, Geoff Levand wrote:
> I want to hook my instrumentation into this config option also, but my
> platform dosn't have PURR, so I would like you to remove the mention
> of '(based on PURR)' in the description of the option.  This way we
> can have a generic 'Hypervisor call instrumentation' option for users,
> on whatever platform they are using.
> 
> Does it make sense?

Makes sense.  No problem.  I'll include this update in a revised edition
of the patch.

Thanks,
-- 
Mike
