Return-Path: <jk@ozlabs.org>
Message-ID: <51B53DAB.10501@ozlabs.org>
Date: Mon, 10 Jun 2013 10:44:59 +0800
From: Jeremy Kerr <jk@ozlabs.org>
MIME-Version: 1.0
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] Please pull powerpc.git merge branch
References: <1370764616.14883.28.camel@pasglop>
 <CA+55aFz_E+x=Mr9Z6_09wzh1mXFr3a2VigPX77LzrsyLUFeb+Q@mail.gmail.com>
 <CA+55aFxAC4EksZcz7SaZNjF9mfKkwLjWp2rEKxMZT8m-7uBeNQ@mail.gmail.com>
In-Reply-To: <CA+55aFxAC4EksZcz7SaZNjF9mfKkwLjWp2rEKxMZT8m-7uBeNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>,
 Patchwork ML <patchwork@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus,

> Is Jeremy the patchwork maintainer?

Yep, that's me.

> and it turns out that apparently 'patchwork' is just making up random
> times, because when you download the email as an mbox, it will turn
> this into that corrupt and incorrect
> 
>     Date: Thu, 06 Jun 2013 19:42:54 -0000
> 
> thing which is apparently how you got the wrong timestamp to begin with.

We keep all patch dates in UTC, but were generating the Date header
incorrectly. Now fixed:

$ wget -qO - http://patchwork.ozlabs.org/patch/249598/mbox/ | grep ^Date
Date: Fri, 07 Jun 2013 05:42:54 -0000

Commit is at:

 http://git.ozlabs.org/?p=patchwork;a=commitdiff;h=e7353352

Cheers,


Jeremy
