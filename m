Mime-Version: 1.0
Message-Id: <v04220801b4d156302cf5@[10.0.0.42]>
In-Reply-To: <14506.39195.886660.256609@ipa.ne.mediaone.net>
References: <14505.54043.936537.924610@ipa.ne.mediaone.net>
 <v04220800b4d0157af3be@[10.0.0.42]>
 <14506.39195.886660.256609@ipa.ne.mediaone.net>
Date: Wed, 16 Feb 2000 23:50:58 -0800
To: R Shapiro <reshapiro@mediaone.net>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: tracking down the source of compilation trouble
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 7:33 AM -0500 2/16/00, R Shapiro wrote:
>Timothy A. Seufert writes:
>  > Hardware problems.  Running a very large build (such as the kernel or
>  > xemacs) is often a good way to smoke out flaky hardware.
>
>Hmm, it's possible, I have had odd behavior occasionally on the 7500.
>Otoh I wouldn't expect this kind of problem to cause repeatable
>compiler errors, always at exactly the same point in the build.

When I had bad kernel compiles due to bad RAM, the error didn't
always occur at the same place, and in fact sometimes it completed.

>One difference I noticed after my initial post is that the 7500 has
>the glibc-2.1.3-0j packages installed, while the G3 has 2.1.3-0b (as a
>reminder, the compilation works on the G3, not on the 7500).  Would
>this be a likely culprit?  Are the 2.1.3-0b packages even downloadable
>anymore?

In order, it could be, and I don't know.

>What other crucial packages (other than gcc, which is the same on both
>machines), are involved in compilation and could generate an internal
>compiler error?

Afraid I can't help there.  Just wanted to point out something that
has happened to me.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
