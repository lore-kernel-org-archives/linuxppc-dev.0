Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9B1A11007D2
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Oct 2010 15:23:56 +1100 (EST)
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) (authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with
	ESMTP id o9M4NqGi030237
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Oct 2010 21:23:52 -0700
Received: by iwn38 with SMTP id 38so598227iwn.15
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Oct 2010 21:23:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1287719462.2198.37.camel@pasglop>
References: <1287719462.2198.37.camel@pasglop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Oct 2010 21:23:30 -0700
Message-ID: <AANLkTi=F1vW4ou47oHJq1DBAHkRMcQMdaUsUMknvXAyr@mail.gmail.com>
Subject: Re: [git pull] Please pull powerpc.git next branch
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 21, 2010 at 8:51 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> Here's powerpc's batch for this merge window.

Ok. Please double-check that I fixed up the merge conflict (due to the
irq_work changes) correctly.

                          Linus
