Date: Mon, 22 Dec 2003 18:27:36 +0100
To: Mark Guertin <mguertin@macdiscussion.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Would setting the CONFIG_RTC option break the powerpc kernel on your machine ?
Message-ID: <20031222172736.GA9999@iliana>
References: <20031217165608.GA11653@iliana> <20031217170620.GS11761@stop.crashing.org> <20031219114050.GA5650@iliana> <20031219162800.GE29266@stop.crashing.org> <20031222134504.GA5964@iliana> <20031222161042.GB10841@stop.crashing.org> <20031222162601.GA9021@iliana> <20031222163315.GC10841@stop.crashing.org> <20031222164822.GA9373@iliana> <A8565590-34A0-11D8-A35A-000A95DC1AB2@macdiscussion.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <A8565590-34A0-11D8-A35A-000A95DC1AB2@macdiscussion.com>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Dec 22, 2003 at 12:02:43PM -0500, Mark Guertin wrote:
>
> On 22-Dec-03, at 11:48 AM, Sven Luther wrote:
>
> >>Does it really have OpenFirmware?
> >
> >Yeah, and i even have the source of it (not free software though). OF
> >coding is a nightmare though.
>
> It's not really OpenFirmware ... it's SmartFirmware is it not?  it's

Yes, it is based on SmartFirmware.

> Slightly OT, but Sven, is there access to /dev/nvram available yet on

No, there is no /dev/nvram, i don't believe there ever will be, not
sure. I think there is no physical nvram for such a device in the
hardware.

> pegasos?  I've still got a forth bootloader menu somewhere here that I
> made for the pegasos, which I've never been able to load (without
> massive typing at SF prompt)...but my pegasos is non functional so I
> may find it this week and email the file to you to fight with :)

Well, my own solution to this, is to implement the boot loader thingy
directly in the OS/SF/whatever. My plan is to have a function to read a
file on disk, which would contain a grub like format (i like it more
than yaboot/lilo like format) and construct a boot-loader menu from
this.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
