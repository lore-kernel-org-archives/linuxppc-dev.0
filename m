Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A0DF1B6F77
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Jul 2011 00:40:49 +1000 (EST)
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with
	ESMTP id p6KEei0O013139
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2011 07:40:46 -0700
Received: by wwi14 with SMTP id 14so4603635wwi.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Jul 2011 07:40:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110720221420.153b0830@kryten>
References: <20110707102107.GA16666@in.ibm.com>
	<1310036375.3282.509.camel@twins>
	<20110714103418.7ef25b68@kryten> <20110714143521.5fe4fab6@kryten>
	<1310649379.2586.273.camel@twins> <20110715104547.29c3c509@kryten>
	<1311024956.2309.22.camel@laptop> <20110719144451.79bc69ab@kryten>
	<1311070894.13765.180.camel@twins> <20110720201436.19e9689a@kryten>
	<1311158708.5345.12.camel@twins> <20110720221420.153b0830@kryten>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 20 Jul 2011 07:40:23 -0700
Message-ID: <CA+55aFxzaaMj8OUaust90c_hYKzg8NpRfmX4SzJ9SMwXzg5ocA@mail.gmail.com>
Subject: Re: [regression] 3.0-rc boot failure -- bisected to cd4ea6ae3982
To: Anton Blanchard <anton@samba.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, mahesh@linux.vnet.ibm.com,
	linux-kernel@vger.kernel.org, mingo@elte.hu, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 20, 2011 at 5:14 AM, Anton Blanchard <anton@samba.org> wrote:
>
>> So with that fix the patch makes the machine happy again?
>
> Yes, the machine looks fine with the patches applied. Thanks!

Ok, so what's the situation for 3.0 (I'm waiting for some RCU
resolution now)? Anton's patch may be small, but that's just the tiny
fixup patch to Peter's much scarier one ;)

                            Linus
