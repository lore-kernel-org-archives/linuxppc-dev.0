Date: Tue, 5 Jan 1999 14:06:48 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: Dan Malek <dmalek@jlc.net>, Paul Mackerras <paulus@cs.anu.edu.au>,
        bh40@calva.net, tmrini@ntplx.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: irq cleanup
In-Reply-To: <Pine.LNX.4.03.9901051001440.28240-100000@mercator.cs.kuleuven.ac.be>
Message-ID: <Pine.LNX.3.96.990105140620.30613B-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Yelloknife has the same thing, but backwards.  That's jumper switchable
though.

}LongTrail CHRP has the output of the master i8259 routed through the OpenPIC.
}So it has 3 interrupt controllers:
}
}  - irq 0-7: master i8259	-> irq 16
}  - irq 8-15: slave i8259	-> irq 2
}  - irq 16-35: OpenPIC in Hydra	-> CPU


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
