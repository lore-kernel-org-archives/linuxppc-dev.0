In-Reply-To: <Pine.LNX.3.96.990118095104.18478A-100000@persephone.cs.nmt.edu>
Date: Mon, 18 Jan 1999 20:26:00 +0100
To: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Choosing an Ethernet controller...
Message-Id: <19990118202600.009236@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I know this is a little bit out-of-topic, but I'm sure someone on this
list can answer and I didn't really know how to actually ask this...

For an embedded developement, I have to choose among 3 different PCI
ethernet controllers. A DEC/Intel 21143 (Tulip), an AMD79C971 (PCNet32)
or a SMC83C171 (Epic100).

The processor will not be a PPC but a StrongARM. (we proposed a PPC, but
the client wanted a StrongARM).
All three seems to be supported by Linux, I will use a 2.0.x kernel at
first, on a StrongARM, but we plan to move to 2.2 once it's stable enough.

Are there any known problems with one of those chips ? Is someone aware
of any specific problem with one of those beasts or it's linux driver ? 

Which one would you choose ?

Thanks !


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
