Return-Path: <jk@ozlabs.org>
Message-ID: <51B553FE.6010201@ozlabs.org>
Date: Mon, 10 Jun 2013 12:20:14 +0800
From: Jeremy Kerr <jk@ozlabs.org>
MIME-Version: 1.0
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] Please pull powerpc.git merge branch
References: <1370764616.14883.28.camel@pasglop>
 <CA+55aFz_E+x=Mr9Z6_09wzh1mXFr3a2VigPX77LzrsyLUFeb+Q@mail.gmail.com>
 <CA+55aFxAC4EksZcz7SaZNjF9mfKkwLjWp2rEKxMZT8m-7uBeNQ@mail.gmail.com>
 <51B53DAB.10501@ozlabs.org>
 <CA+55aFzHT3NWrF6gq+BaLcZmEtrFwkiXv0_qZ0jGjxTO6-8iPQ@mail.gmail.com>
In-Reply-To: <CA+55aFzHT3NWrF6gq+BaLcZmEtrFwkiXv0_qZ0jGjxTO6-8iPQ@mail.gmail.com>
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

> No. The date from the email was
> 
>     Date: Fri, 7 Jun 2013 15:42:54 +1000
> 
> and we want *that* date.

Ah, gotchya.

So, we now use the original date header (if present) in the mbox views:

$ wget -qO - http://patchwork.ozlabs.org/patch/249598/mbox/ | grep ^Date
Date: Fri, 7 Jun 2013 15:42:54 +1000

... for all your data-mining needs.

Cheers,


Jeremy
