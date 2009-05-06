Return-Path: <markus@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [216.239.33.17])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 08DB4DDE06
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 04:46:33 +1000 (EST)
Received: from zps18.corp.google.com (zps18.corp.google.com [172.25.146.18])
	by smtp-out.google.com with ESMTP id n46IkQZ3005272
	for <linuxppc-dev@ozlabs.org>; Wed, 6 May 2009 19:46:27 +0100
Received: from yw-out-2324.google.com (ywj3.prod.google.com [10.192.10.3])
	by zps18.corp.google.com with ESMTP id n46IkOKt027271
	for <linuxppc-dev@ozlabs.org>; Wed, 6 May 2009 11:46:25 -0700
Received: by yw-out-2324.google.com with SMTP id 3so140171ywj.81
	for <linuxppc-dev@ozlabs.org>; Wed, 06 May 2009 11:46:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
References: <20090228030226.C0D34FC3DA@magilla.sf.frob.com>
	<20090228030413.5B915FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902271932520.3111@localhost.localdomain>
	<alpine.LFD.2.00.0902271948570.3111@localhost.localdomain>
	<20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
Date: Wed, 6 May 2009 11:46:24 -0700
Message-ID: <904b25810905061146ged374f2se0afd24e9e3c1f06@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
From: =?UTF-8?B?TWFya3VzIEd1dHNjaGtlICjpoaflrZ/li6Qp?= <markus@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Cc: linux-mips@linux-mips.org, x86@kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, stable@kernel.org,
	Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Feb 28, 2009 at 10:23, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> And I guess the seccomp interaction means that this is potentially a
> 2.6.29 thing. Not that I know whether anybody actually _uses_ seccomp. It
> does seem to be enabled in at least Fedora kernels, but it might not be
> used anywhere.

In the Linux version of Google Chrome, we are currently working on
code that will use seccomp for parts of our sandboxing solution.


Markus
