In-Reply-To: <Pine.CVX.3.93.990107184738.21285A-100000@atlas.cc.uoa.gr>
Date: Thu, 7 Jan 1999 18:37:27 +0100
To: linuxppc-dev@lists.linuxppc.org,
        Konstantinos Margaritis <kmargar@cc.uoa.gr>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: MouseSystems MacoPoint Pro, 3 btn mouse
Message-Id: <19990107183727.001350@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 7, 1999, Konstantinos Margaritis <kmargar@cc.uoa.gr> wrote:

>Actually, after I tested the MacX patch by Kelly Campbell -although I had
>to tweak it a bit, since I use 2.1.131 kernel- I found out it works
>perfectly with the Macpoint Pro mouse, so instead of sending you my mouse,
>I would suggest that this patch be inserted to the official kernel tree.
>That would be best, IMHO.

This patch is already included in my tree, but I think I have a problem
with one of the buttons, I'll have to re-check my code carefully.

I suggest you try a 2.2-pre4 with my test patch (download just the diffs
next to the test kernel) and enable the MacX option in the config. Tell
me how it works, and if it doesn't, you may eventually be able to tell me
what is broken. I may have missed something simple, I juste putted it in
quickly, it probably needs a little bit of work.

Actually, I'm interested in the theory behind this patch. Is the
"official" behaviour of MacX mice documented somewhere ? I'm thinking
about things like "can a MacX mouse be handler 2 or 4 or can it be only
handler 1 ?". With answers to this, I may be able to auto-disable the
patch when I know for sure it's a normal mouse, and this allow the same
kernel to work with both kind of mice. I already have some "hints" about
the way to do that but I want to be sure and to be able to test ;-)

I think I'll end up just buying one.

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
