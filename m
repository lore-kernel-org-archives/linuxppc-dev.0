Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <v04011700b290dbe414c6@[129.116.170.246]>
In-Reply-To: <366AD42E.C03C7D64@gladstone.uoregon.edu>
References: <Pine.LNX.4.05.9812051953170.954-100000@pc.wackyland.com>
Date: Sun, 6 Dec 1998 19:14:05 -0600
To: Louis Kowolowski <lkowolow@gladstone.uoregon.edu>,
        linuxppc-dev@lists.linuxppc.org
From: Mike DeSimone <Hot-Wire@mail.utexas.edu>
Subject: Re: mousemode
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>how do you change/force mousemode to a different setting?
>i've attempted to use mousemode 15 4 but it tells me that the current setting
>is 1, attempts to change it to 4, and leaves it at 1...  any ideas?
>thanks

The first number is the ADB device ID.  Try different ones (0-15) for it.
I'd recommend starting at 14 and going down until you find a device that
changes.
_________________________________________________________________________
                                __________
##   ##   ###   #####   #####   \********/   #####    ###    ##### ######
### ###  ## ##  ##  ## ##        \*/\/\*/    ##  ##  ## ##  ##     ##
#######  ## ##  #####   ####       /\/\      #####   ## ##   ####  ####
## # ## ####### ##  ##     ##      \**/      ##  ## #######     ## ##
##   ## ##   ## ##  ## #####        \/       #####  ##   ## #####  ######
_________________________________________________________________________
### Mike DeSimone ### Hot-Wire@mail.utexas.edu ### ares.marsbase.mars ###

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
