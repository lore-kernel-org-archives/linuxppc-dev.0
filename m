Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1CC3FDDE01
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2008 20:23:23 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Fix msr check in compat_sys_swapcontext
References: <jeprlabbi6.fsf@sykes.suse.de>
	<18706.16317.759662.855430@cargo.ozlabs.ibm.com>
Date: Thu, 06 Nov 2008 10:23:16 +0100
In-Reply-To: <18706.16317.759662.855430@cargo.ozlabs.ibm.com> (Paul
	Mackerras's message of "Thu, 6 Nov 2008 11:52:13 +1100")
Message-ID: <jey6zx9piz.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> we need to use get_user, not __get_user, since we haven't done an
> access_ok() check on the address.

The address is always ok since its a compat pointer, see do_setcontext.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
