From: o.moerbeek@syllogic.com
Reply-To: otto@cable.a2000.nl
To: linuxppc-dev@lists.linuxppc.org
cc: gewrgiou@imbc.gr, rshaw@inficad.com, otto@cable.a2000.nl
Message-ID: <C12567C4.005220FB.00@syllogic.com>
Date: Thu, 5 Aug 1999 16:57:03 +0200
Subject: Re: 2.2.10 kernel and Apple ISO USB keyboards
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




Hi to you all,

With some help from  Kostas Gewrgiou (thanks!) I solved my keyboard key to mouse
button mapping problem. There's a How To on <http://www.xs4all/nl~om>. The
tricky part for me was seeing that due to some Xautoconfig problem the X server
did not use the xkb extension. Actually xkb not only works with USB ISO
keyboards, but with ALL Mac keyboards, be it ADB or USB.

Happily running 2.2.10,
Otto

--
Otto Moerbeek
otto@cable.a2000.nl



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
