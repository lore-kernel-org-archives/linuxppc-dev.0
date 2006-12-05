Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 0228B67B6D
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 18:41:15 +1100 (EST)
Date: Tue, 5 Dec 2006 08:41:10 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Paul Mackerras <paulus@samba.org>
Subject: Re: master branch reset
In-Reply-To: <17780.2568.641734.276805@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.62.0612050839120.12448@pademelon.sonytel.be>
References: <17780.2568.641734.276805@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 4 Dec 2006, Paul Mackerras wrote:
> If you are following the master branch, throw away the old master
> branch and grab the new one.  Once the mirrors have caught up, you can
> do this with:
> 
> $ git fetch git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git
> $ git reset --hard FETCH_HEAD

I did this yesterday. But when I wanted to update, I got:

| pademelon$ git pull -v
| Unpacking 1595 objects
|  100% (1595/1595) done
| * committish: ef6a3165e75c189da82c943a081cd1da52068738
|   branch 'for-2.6.20' of git://www.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc
| * refs/heads/for-2.6.20: same as branch 'for-2.6.20' of git://www.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc
| * committish: e62438630ca37539c8cc1553710bbfaa3cf960a7
|   branch 'master' of git://www.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc
| * refs/heads/origin: does not fast forward to branch 'master' of git://www.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc;
|   not updating.
| pademelon$

2nd try:

| pademelon$ git fetch git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git
| Unpacking 1595 objects
|  100% (1595/1595) done
| pademelon$ git reset --hard FETCH_HEAD
| pademelon$ git pull -v * committish: ef6a3165e75c189da82c943a081cd1da52068738
|   branch 'for-2.6.20' of git://www.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc
| * refs/heads/for-2.6.20: same as branch 'for-2.6.20' of git://www.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc
| * committish: e62438630ca37539c8cc1553710bbfaa3cf960a7
|   branch 'master' of git://www.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc
| * refs/heads/origin: does not fast forward to branch 'master' of git://www.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc;
|   not updating.
| pademelon$

Any clues? Delete and reclone?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
