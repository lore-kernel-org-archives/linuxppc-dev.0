Message-ID: <3CBC59C0.7000505@cymes.de>
Date: Tue, 16 Apr 2002 19:05:04 +0200
From: Matthias Grimm <joker@cymes.de>
MIME-Version: 1.0
To: PPC-Dev Mailingliste <linuxppc-dev@lists.linuxppc.org>
Subject: muteing speakers if headphones were plugged in?
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I was asked to built a new feature into pbbuttons: To mute the speakers
if headphones are plugged in.

I don't know where to get the information if headphones are plugged in
or not, so I had a look into the recent kernel and I saw some code (for
eg. headphone_intr() ) that seems to do what I am asked for. On the
other hand the code seems very experimental and not really complete as I
could see at some comments.

What is the status? Should this feature (muting the speakers ...) be
part of the kernel or was it only a fast shot to get it work?

I saw the most headphone code within the Tumbler section so I assume
that it would only work on new TiBooks and iBooks?

Nevertheless is there a method to get the information of the line-in
jack status from user space?

  Thanks for your help and best regards
     Matthias


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
