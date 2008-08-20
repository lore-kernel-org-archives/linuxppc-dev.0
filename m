Return-Path: <timur.tabi@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.225])
	by ozlabs.org (Postfix) with ESMTP id 57023DDF60
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 21:28:42 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id c48so339092wra.1
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 04:28:40 -0700 (PDT)
Message-ID: <ed82fe3e0808200428v7eb53526l3f2632ac0c406734@mail.gmail.com>
Date: Wed, 20 Aug 2008 06:28:40 -0500
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: "Tony Breeds" <tony@bakeyournoodle.com>
Subject: Re: [PATCH] powerpc: fix memory leaks in QE library
In-Reply-To: <20080820063850.GK934@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1219093928-5349-1-git-send-email-timur@freescale.com>
	<20080820063850.GK934@bakeyournoodle.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 20, 2008 at 1:38 AM, Tony Breeds <tony@bakeyournoodle.com> wrote:

> It's been pointed out in
> http://bugzilla.kernel.org/show_bug.cgi?id=11371
> that ucc_slow suffers from the same (welll clsoe enough) 2 problems.
> Care to fix them aswell?

Sure.  I'll do a sweep o the QE code just to make sure there aren't even more.

Of course, it would have been nice if someone had looked up the
maintainer of the QE library in the MAINTAINERS file and notified me
about these bugs.

-- 
Timur Tabi
Linux kernel developer at Freescale
