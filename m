In-Reply-To: <9902141703.AA37524@marc.watson.ibm.com>
Date: Sun, 14 Feb 1999 19:58:05 +0100
To: David Edelsohn <dje@watson.ibm.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: bootstrap stuffs
Message-Id: <19990214195805.018190@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Feb 14, 1999, David Edelsohn <dje@watson.ibm.com> wrote:

>	For correctness, "sync" must be used, but for best performance,
>"sync" should be used sparingly, only when necessary.

Ok thanks. In this specific case (jump to bootstrap), I don't really care
about the performance loss introduced by a sync, I'll keep one just after
the mtmsr to make sure that the interrupt switch is fully done before I
hack with srr0 and the MMU.

For the relocatable code, I'll still unvestigate the issue for my own
education, but I beleive I don't need it anymore, I just wrote most of
the code in asm this morning ;-) (PPC asm is frightening at fist, but
finally it was not so difficult).

So thanks David and Michael (and thanks again to Terry Greeniaus), I now
have all the elements I need to do what I want.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
