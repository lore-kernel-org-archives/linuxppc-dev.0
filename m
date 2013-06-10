Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CA+55aFxJxY3J2X7DsEY4nz050PmNFgsZRewQEPoVWc1gzdiLGw@mail.gmail.com>
References: <1370764616.14883.28.camel@pasglop>
 <CA+55aFz_E+x=Mr9Z6_09wzh1mXFr3a2VigPX77LzrsyLUFeb+Q@mail.gmail.com>
 <CA+55aFxAC4EksZcz7SaZNjF9mfKkwLjWp2rEKxMZT8m-7uBeNQ@mail.gmail.com>
 <51B53DAB.10501@ozlabs.org>
 <CA+55aFzHT3NWrF6gq+BaLcZmEtrFwkiXv0_qZ0jGjxTO6-8iPQ@mail.gmail.com>
 <CA+55aFxJxY3J2X7DsEY4nz050PmNFgsZRewQEPoVWc1gzdiLGw@mail.gmail.com>
Date: Sun, 9 Jun 2013 20:36:17 -0700
Message-ID: <CA+55aFx684C7k8=2Fk53AOvfSkfUb_6DncCnOM8zU=jdhOQMuA@mail.gmail.com>
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

On Sun, Jun 9, 2013 at 8:20 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> .. the rationale for this is that the work pattern of people is
> actually interesting information. You can do things like this:
>
>     git log --pretty=%aD --author=Torvalds

Final side note: for me, and other git users that apply other peoples
patches, it's probably better to use

   git log --pretty=%cD --committer=Torvalds

instead.

Interestingly, that shows a different pattern than my "authorship"
statistics, which are mainly pull requests. It turns out I commit
patches much more in the afternoon. The reason is probably simple: in
the mornings, I have pull requests waiting from overnight, so a fair
number of pull requests where I am author at 9-11. But my biggest
source of patches tends to be Andrew Morton, who sends the patches in
the afternoon, so suddenly the commit counts skew towards being
between 3pm-8pm when you take all my commits into accoint.

Doing

    git log --since=6.months --pretty=%aD --grep=Signed.*Andrew.Morton

backs that up: most of the commits that have sign-offs by Andrew are
sent in the afternoon.

I just find details like that really interesting, where you can
actually mine for the workpatterns of people.

                   Linus
