Return-Path: <bzolnier@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.186])
	by ozlabs.org (Postfix) with ESMTP id 7BE89DDDFD
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 22:00:31 +1000 (EST)
Received: by fk-out-0910.google.com with SMTP id e30so4915888fke.9
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 05:00:29 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: ide pmac breakage
Date: Tue, 29 Jul 2008 13:41:14 +0200
References: <1217208596.11188.144.camel@pasglop>
	<20080729141750V.fujita.tomonori@lab.ntt.co.jp>
	<1217308857.11188.237.camel@pasglop>
In-Reply-To: <1217308857.11188.237.camel@pasglop>
MIME-Version: 1.0
Message-Id: <200807291341.14724.bzolnier@gmail.com>
Content-Type: text/plain;
  charset="utf-8"
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org,
	petkovbb@gmail.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 29 July 2008, Benjamin Herrenschmidt wrote:
> On Tue, 2008-07-29 at 14:17 +0900, FUJITA Tomonori wrote:
> > If q->elevator is NULL, the media-bay code might mess up the ref
> > counting of the request queue...
> 
> Well, all I do is call into Bart's new helpers to scan for or unregister
> devices ...

The switch to these helpers happened _before_ 2.6.26 and it shouldn't bring
such behavior change (ditto for new IDE host addition/removal helpers)...

Please try to git-bisect it when you have some time.

Thanks,
Bart
