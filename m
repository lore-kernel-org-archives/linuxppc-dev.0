Date: Thu, 31 Dec 1998 14:43:45 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: Paul Mackerras <paulus@cs.anu.edu.au>, Dan Malek <dmalek@jlc.net>,
        Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>,
        bh40@calva.net, tmrini@ntplx.net
cc: linuxppc-dev@lists.linuxppc.org
Subject: irq cleanup
Message-ID: <Pine.LNX.3.96.981231143743.14310A-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I was adding code for the QSPAN interrupts on the mbx when I decided it
would take as much work to hack it in as to redesign irq.c.  This isn't
done, but I wanted to show you what direction I was going in and get
some feedback on it.  I'm basing it on the Ingo design a bit but with some
changes so it's a better match with the ppc hardware.

This will also help with adding the yellowknife when I get a chance to
start on that.

The idea is to have a master controller, and each slave is dealt with as a
handler so we don't have such an ifdef soup.

I have it going on the powerbook now.  I'll test it out on chrp and prep
next then finish up the qspan stuff.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
