Date: Sun, 24 Jan 1999 23:11:14 -0600 (CST)
From: Ken Roberts <ken@worldnet.att.net>
Reply-To: Ken Roberts <ken.r@worldnet.att.net>
To: Tom Harrington <tph@rmi.net>
cc: Robin Colgrove <robin@louis.bidmc.harvard.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Linux and Mac together (Was: Re: mac-on-linux project status)
In-Reply-To: <199901250055.RAA20183@shell.rmi.net>
Message-ID: <Pine.LNX.3.96.990124230812.434A-100000@dancer.at.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Maybe I am just not understanding this but if both MkLinux and OS X run on 
>> top of the Mach microkernel, could they both be running simultaneously? If 
>
>In principle, yes,  Mach is capable of running multiple server operating 
>systems at the same time.  I have no idea what's involved in making this
>happen, but supposedly one of the advantges of a microkernel-based Linux

this was explained to the mklinux list quite some time back.  i believe this
will not work because mklinux and osx use different versions of the mach kernel.

from what i remember, mklinux uses a more recent kernel than the official apple
stuff.  the interfaces are different enough so that the two worlds are
incompatible.


--------------------------------------------------------------------------------
Ken Roberts                                               ken.r@worldnet.att.net
"A mechanism of world intercommunication will be devised, embracing the whole
planet, freed from national hindrances and restrictions, and functioning with
marvelous swiftness and perfect regularity."
                                                        (Shoghi Effendi, 1936)


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
