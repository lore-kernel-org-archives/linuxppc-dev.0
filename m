Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 38DFFB6F76
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Jul 2011 02:04:45 +1000 (EST)
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with
	ESMTP id p6KG4LRF020414
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2011 09:04:22 -0700
Received: by wwj40 with SMTP id 40so315101wwj.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Jul 2011 09:04:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1311173910.5345.94.camel@twins>
References: <20110707102107.GA16666@in.ibm.com>
	<1310036375.3282.509.camel@twins>
	<20110714103418.7ef25b68@kryten> <20110714143521.5fe4fab6@kryten>
	<1310649379.2586.273.camel@twins> <20110715104547.29c3c509@kryten>
	<1311024956.2309.22.camel@laptop> <20110719144451.79bc69ab@kryten>
	<1311070894.13765.180.camel@twins> <20110720201436.19e9689a@kryten>
	<1311158708.5345.12.camel@twins> <20110720221420.153b0830@kryten>
	<CA+55aFxzaaMj8OUaust90c_hYKzg8NpRfmX4SzJ9SMwXzg5ocA@mail.gmail.com>
	<1311173910.5345.94.camel@twins>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 20 Jul 2011 09:04:00 -0700
Message-ID: <CA+55aFxpH9-4rkH6CRXbjFCQMGNYGRMKgdgHUEthefQPumFKVg@mail.gmail.com>
Subject: Re: [regression] 3.0-rc boot failure -- bisected to cd4ea6ae3982
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mahesh@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
	Anton Blanchard <anton@samba.org>, mingo@elte.hu,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 20, 2011 at 7:58 AM, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
>
> Right, so we can either merge my scary patches now and have 3.0 boot on
> 16+ node machines (and risk breaking something), or delay them until
> 3.0.1 and have 16+ node machines suffer a little.

So how much impact does your scary patch have on machines that don't
have multiple nodes? If it's a "the code isn't even called by normal
machines" kind of setup, I don't think I care a lot.

                  Linus
