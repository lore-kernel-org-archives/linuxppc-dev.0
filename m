In-Reply-To: <v04020a00b2e6f5596238@[136.152.65.18]>
Date: Wed, 10 Feb 1999 14:20:25 +0100
To: Brian C Burke <bcburke@socrates.berkeley.edu>,
        linuxppc-dev@lists.linuxppc.org
From: BenH <bh40@calva.net>
Subject: Re: v2.2.1 and serial fixes
Message-Id: <19990210142025.007673@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Feb 10, 1999, Brian C Burke <bcburke@socrates.berkeley.edu> wrote:

>Over the last few weeks I seen reference to BenH fixing some serial driver
>bugs that may be involved in ppp hangs. I grapped the 2.2.1 kernel in hopes
>that these fixes were incorporated. Unfortunatelly I'm still finding ppp
>connections often hang and the only fix is to reboot. If I boot into
>mklinux ppp is stone reliable, so the problem is in linuxppc  Were the
>serial fixes incorporated in 2.2 or do I need to get the latest sources?

I'm not 100% sure I have have fixed _all_ the problems, but PPP works
reliably for me using the internal modem of the PowerBook. The fixes are
currently in vger or in Paul's kernel. I beleive the binary snapshot on
samba.anu.edu.au do have them. Are you using a kernel.org kernel distrib
? This one may lack the latest PPC patches.
-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
