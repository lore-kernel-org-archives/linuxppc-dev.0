Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <51B553FE.6010201@ozlabs.org>
References: <1370764616.14883.28.camel@pasglop>
 <CA+55aFz_E+x=Mr9Z6_09wzh1mXFr3a2VigPX77LzrsyLUFeb+Q@mail.gmail.com>
 <CA+55aFxAC4EksZcz7SaZNjF9mfKkwLjWp2rEKxMZT8m-7uBeNQ@mail.gmail.com>
 <51B53DAB.10501@ozlabs.org>
 <CA+55aFzHT3NWrF6gq+BaLcZmEtrFwkiXv0_qZ0jGjxTO6-8iPQ@mail.gmail.com>
 <51B553FE.6010201@ozlabs.org>
Date: Sun, 9 Jun 2013 21:24:23 -0700
Message-ID: <CA+55aFwWdYVnOPWN04x+WUkis3pTOk97gpWpM2y9hRvSiGh1Hg@mail.gmail.com>
Subject: Re: [git pull] Please pull powerpc.git merge branch
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Jeremy Kerr <jk@ozlabs.org>
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

On Sun, Jun 9, 2013 at 9:20 PM, Jeremy Kerr <jk@ozlabs.org> wrote:
>
> So, we now use the original date header (if present) in the mbox views:
>
> $ wget -qO - http://patchwork.ozlabs.org/patch/249598/mbox/ | grep ^Date
> Date: Fri, 7 Jun 2013 15:42:54 +1000
>
> ... for all your data-mining needs.

Goodie, and I see that it even works with old patches. Thanks.

               Linus
