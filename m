Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id D9766DDE03
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Aug 2008 16:27:24 +1000 (EST)
Date: Tue, 5 Aug 2008 02:27:23 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [git pull] Please pull powerpc.git merge branch
Message-ID: <20080805022723.31df2f98@lappy.seanm.ca>
In-Reply-To: <20080805021205.438365c0@lappy.seanm.ca>
References: <18582.35404.120586.238398@drongo.ozlabs.ibm.com>
	<20080805021205.438365c0@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

False alarm. They hardcoded the arch into the include. So

#include <asm-powerpc/time.h>

no longer works but

#include <asm/time.h>

does. This is an artifact from when we where trying to use arch/ppc.

Cheers,
   Sean
