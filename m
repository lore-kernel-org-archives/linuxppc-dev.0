Date: Fri, 26 Feb 1999 00:18:44 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: VALETTE Eric <valette@crf.canon.fr>
cc: jpeters@phx.mcd.mot.com, paubert@iram.es, jeremy@goop.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Interrupt routing in prep_pci.c
In-Reply-To: <m10FKAv-0000WXC@tri-yann.crf.canon.fr>
Message-ID: <Pine.LNX.3.96.990226001517.16892D-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I disagree with that quite a bit.  I don't believe that we can allow the
"support in this version, not in the next, now in the next..." type of
flip-flop.  

We can move ahead and we need to do it quickly, yes.  So lets do that.  My
previous message details my plan.  If there aren't any serious objections
lets get working rather than trying to use our own bootloaders.  Lets
merge them or failing that provide a few different ones.

If we can't do things that way I'll need to stick with the current
bootloader and just start taking patches against that to get things
working.  I don't think that's a good solution since the current loader is
broken.

}  2) Value of a patch should be mesured in number of additionnal cards that works with
}  a patch versus the number of boards it breaks AND a cleaner design.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
