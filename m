Message-Id: <199812200843.DAA10162@foo.icanect.net>
Date: Sun, 20 Dec 1998 03:45:30 +0000
Subject: Re: turbo mouse woes
From: "J. Benjamin" <macnet@icanect.net>
To: Tom Harrington <tph@rmi.net>
CC: LinuxPPC User <linuxppc-user@lists.linuxppc.org>,
        linuxPPC-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The maintainer of the FAQoMatic created something called "mousehack" which
worked for me but it only works with an outdated kernel, 2.1.14. Perhaps
someone can download it's source and update it for the latest kernels? It
can be found at <ftp://ftp.cs.dartmouth.edu/pub/jonh/linux-pmac/>


>> I have a kensington turbo mouse 5.0 hooked up to my linuxppc machine and
>> like so many, am trying to get reasonable 3-button behavior out of it. I've
>
>Unfortunately it begins to look as though version 5.0 of the Turbo
>Mouse does not support the ADB extended mouse protocol, which makes
>three-button operation a problem.  Neither mousemode nor xmodmap seems
>to help in distinguishing one mouse button from another.
>
>> done a search on the archives and in the interactive faq and have exhaused
>> the suggestions there. The familiar problem is that all of the buttons
>> produce the same behavior which is to emulate button 2 (I think--It pops up
>> contextual menus). When I run 
>> 
>> xmodmap -e "pointer = default"
>> 
>> All of the buttons act like button one, which is at least usable. I can get
>> the other buttons by holding down options, cmd etc.
>
>That's interesting, as I had never seen anything but button 1 behavior
>from my TurboMouse.  I'd be interested to see what xmodmap reports
>about the pointer _before_ you do this ("xmodmap -pke", if I recall).
>
>> What's odd is that when I was booting with the installer.coff file on the
>> v4 cd-rom, the 3 buttons responded as I expected them to. Since I've
>> started booting with bootx, using a 2.1x kernal, the mousing is funny.
>
>Most interesting, that.  I shall have to look at the installer.coff
>and see if there are any clues for fixing this with 2.1.x.  How did the
>four TurboMouse buttons map to three-button behavior?  That is, which
>TurboMouse button did what?
>
>> Are there magic mousemode arguments that I need or do I need to be passing
>> the kernal different arguments on startup? Any help is appreciated...
>
>I don't think so.  But if you happen to find some, please post your
>results to this list.
>
>Tom
>
>
>[[ This message was sent via the linuxppc-user mailing list. Replies are ]]
>[[ not forced back to the list, so be sure to  Cc linuxppc-user  if your ]]
>[[ reply is of general interest. To unsubscribe from linuxppc-user, send ]]
>[[ the message 'unsubscribe' to linuxppc-user-request@lists.linuxppc.org ]]
>


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
