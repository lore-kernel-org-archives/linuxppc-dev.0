From: Benjamin Herrenschmidt <bh40@calva.net>
To: Takashi Oe <toe@unlserve.unl.edu>,
        linuxppc-dev
 <linuxppc-dev@lists.linuxppc.org>
Subject: Re: LinuxPPC X Server
Date: Mon, 31 Jul 2000 16:07:48 +0200
Message-Id: <20000731140748.1481@mailhost.mipsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> >> - A likely timeframe for first 3D Drivers
>> >>   to be released, which optimally should
>> >>   not be more than 3 months from now
>>
>> >Again, what is not working for you?  What have you tried to get them
>> >working for you and how did it fair?
>>
>> I cannot try getting something to work what does not exist. And appearently
>> there are no GLX- or DRI-Drivers for ATI Rage (or any other hardware) yet.
>> I am talking about Hardware Accelerated Mesa3D here...
>
>Ok, you should say so (3D support for older video cards like ATI Rage) in
>your previous message then.  As you may know, DRI drivers already exist
>for mga, r128, tdfx, i810 in source form.
>

I'm working on a /dev/agpgart implementation for new machines. But DRI
should be already port-able using the PCI GART provided by most ATI
chipsets. Any volunteer ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
