Message-ID: <371E0313.C0FF665C@fi.infn.it>
Date: Wed, 21 Apr 1999 18:55:47 +0200
From: Simone Piccardi <Simone.Piccardi@fi.infn.it>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Un-Setting VME3PCI Master Master Enable on MVME2431
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
today I got another "little" trouble with our board.
We finally get a dataway display that cannot work. After many attempts
to use it (it was perfectly working in other crates) we try to go back
to the default configuration of the board (I switched to VME3PCI Master
Master Enable = N according to what said in the mailing list to boot the
kernel) and everything went working.
The manual said:
N do not enable the VME Bus Interface

So is this only related to the PPCBug (and with a working kernel all
will be OK?) Or I have to worry?
Probably this is a stupid question, but as I said I'm totally new to
VME.
Thanks

-- 
Simone Piccardi
Microsoft is NOT the answer. Microsoft is the Question.
The answer is: "NO!"

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
