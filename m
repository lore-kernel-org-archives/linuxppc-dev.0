Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CC0BFB70D6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Oct 2010 17:19:54 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id o917Js7g003856
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:19:54 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o917Jscr1179760
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:19:54 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o917Jr4M003055
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:19:54 +1000
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH 02/18] powerpc: Add CROSSBE_COMPILE to build big endian
	boot wrapper
From: Ian Munsie <imunsie@au1.ibm.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
In-reply-to: <AANLkTi=VmSXN6XeD__nkQLJAYXzxOh6WEtW6-jjJcC4Q@mail.gmail.com>
References: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
	<1285916771-18033-3-git-send-email-imunsie@au1.ibm.com>
	<AANLkTi=VmSXN6XeD__nkQLJAYXzxOh6WEtW6-jjJcC4Q@mail.gmail.com>
Date: Fri, 01 Oct 2010 17:19:54 +1000
Message-Id: <1285917531-sup-3488@au1.ibm.com>
Cc: Michal Marek <mmarek@suse.cz>, Sam Ravnborg <sam@ravnborg.org>,
	Albert Herranz <albert_herranz@yahoo.es>,
	linux-kernel <linux-kernel@vger.kernel.org>, paulus <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Geert Uytterhoeven's message of Fri Oct 01 17:13:19 +1000 2010:
> Shouldn't the help text added by [PATCH 01/18]:
....
> be updated here as well?

Yep, you're right. Thanks for pointing that out, I'll fix it for the next
revision.

Cheers,
-Ian
