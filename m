Message-ID: <369C5745.55B3@post.uni-bielefeld.de>
Date: Wed, 13 Jan 1999 09:20:21 +0100
From: "Jens Ch. Restemeier" <jenschrr@post.uni-bielefeld.de>
Reply-To: jenschrr@post.uni-bielefeld.de
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: AtyFB problem solved -> should go into a FAQ or something
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi !

I solved my problems with atyfb (I hope): The cause for the blank/black
screen was not the driver, but the protection-mechanisms of the monitor
!

My 5500 has a built-in monitor, and I'm normally running vmode 13.
My "normal" boot looked like:

video=ofonly vmode=13

for atyfb I did

video=atyfb vmode=13

It looks like the vmode stuff has changed, because after writing

video=atyfb:vmode:13

it works ! 

Jens

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
