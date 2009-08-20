Return-Path: <rbrito@ime.usp.br>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 99842B7B7B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 08:23:22 +1000 (EST)
Received: from relay8.uol.com.br (relay8.uol.com.br [187.17.116.6])
	by ozlabs.org (Postfix) with ESMTP id 16993DDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 08:23:22 +1000 (EST)
Received: from smtp.uol.com.br (unknown [172.26.20.83])
	by sulu2.uol.com.br (Postfix) with ESMTP id DABBB50007963
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Aug 2009 19:17:20 -0300 (BRT)
Received: from localhost (localhost [127.0.0.1])
	by socom7.uol.com.br (Postfix) with ESMTP id 727F8180000B2
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Aug 2009 19:17:12 -0300 (BRT)
Received: from chagas.nectar.ath.cx (unknown [187.22.248.83])
	by socom7.uol.com.br (Postfix) with ESMTPA id 5769A180000AF
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Aug 2009 19:17:10 -0300 (BRT)
Date: Thu, 20 Aug 2009 19:17:10 -0300
From: =?utf-8?Q?Rog=C3=A9rio?= Brito <rbrito@ime.usp.br>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 14021] New: hfsplus caused data loss
Message-ID: <20090820221710.GA826@ime.usp.br>
References: <bug-14021-10286@http.bugzilla.kernel.org/>
	<20090820150242.a4b5eccc.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090820150242.a4b5eccc.akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Andrew.

On Aug 20 2009, Andrew Morton wrote:
> On Thu, 20 Aug 2009 02:17:21 GMT
> bugzilla-daemon@bugzilla.kernel.org wrote:
> > ,----
> > | [30991.501804] loop: module loaded
> > | [30991.513337] hfs: create hidden dir...
> > | [39897.867830] hfs: create hidden dir...
> > | [39960.061622] hfs: splitting index node...
> > `----
> > 
> > No stack traces, no nothing. Oh, I still have the disk image that I
> > created, if it is of any interest.
>
> Gee.  Nobody really does much maintenance work on hfs/hfsplus any more.

Right.

I think that I could run some stress tests (say, like the exhaustive
regression tests that the ntfs-3g developers use), just to get some
basic functionality on HFS+ working.

> I cc'ed the ppc guys as I expect that most HFS users are over there.

Thanks once again, Andrew.

> It seems like a pretty gross failure - others should be hitting it.
> 
> I wonder if it's a weird interaction with the loop driver.

Just to make it clear: the reason why I loop-mounted the filesystem was
just to work with a low-risk situation and submit the image to the
recently "ported" fsck, just to get a little bit more confidence that I
didn't mess with the userspace side of things.

But, then, this surprise.

I had some minor inconsistencies with the HFS+ driver in the past, but
they were fixed by running the fsck.hfsplus that I packaged and I didn't
bother reporting it before. My mistake. :-(


Thanks, Rogério Brito.

-- 
Rogério Brito : rbrito@{mackenzie,ime.usp}.br : GPG key 1024D/7C2CAEB8
http://www.ime.usp.br/~rbrito : http://meusite.mackenzie.com.br/rbrito
Projects: algorithms.berlios.de : lame.sf.net : vrms.alioth.debian.org
