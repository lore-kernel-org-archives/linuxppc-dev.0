Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EA3EFB7D13
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 20 Apr 2010 17:37:06 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp08.au.ibm.com (8.14.3/8.13.1) with ESMTP id o3K7bIvJ029502
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Apr 2010 17:37:18 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3K7b67q1138918
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Apr 2010 17:37:06 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o3K7b5bI013923
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Apr 2010 17:37:05 +1000
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH v4] perf: Split out arch specific code & improve PowerPC
	perf probe support
From: Ian Munsie <imunsie@au1.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
In-reply-to: <1271746713-8347-1-git-send-email-imunsie@au1.ibm.com>
References: <1271746713-8347-1-git-send-email-imunsie@au1.ibm.com>
Date: Tue, 20 Apr 2010 17:36:37 +1000
Message-Id: <1271748940-sup-3011@au1.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Masami Hiramatsu <mhiramat@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Ian Munsie's message of Tue Apr 20 16:58:31 +1000 2010:
> Here's the 4th version of the perf probe PowerPC support and perf arch specific
> infrastructure patches rebased on top of tip/perf/core.

That should read "rebased on top of tip/master".

Cheers,
-Ian
