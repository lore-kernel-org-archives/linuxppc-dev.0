Date: Fri, 12 Oct 2001 11:29:01 -0700
Subject: Re: no luck with Adaptec SCSI controller in 2.4.X
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v472)
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>,
	linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.yellowdoglinux.com
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
From: "David A. Gatwood" <dgatwood@apple.com>
In-Reply-To: <20011012181138.FUFA17332.tomts11-srv.bellnexxia.net@there>
Message-Id: <01CBA9F0-BF3F-11D5-A238-003065B90BBC@apple.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Friday, October 12, 2001, at 11:13 AM, Kevin B. Hendricks wrote:

>>>> Perhaps the drive
>>>> will function correctly if tagged queing is disabled for it.  You
>>>> can do this only for target 1 with the "tag_info" option.  There may
>>>> also be firmware updates for this drive.
>
> Okay I used tag_info as you directed and set the Quantum Fireball drive
> to
> use a maximum tag depth of 8 (like the old driver used) and everything
> seems to work fine.
>
> So can you point me to where in your driver code the depth of the tagged
> queueing is dynamically determined?  I would like to play around a bit
> with the driver code to see if I can tell if the Quantum Fireball is
> simply spitting back bogus info or and if so what?

IIRC, early Fireball models reported support for TCQ and didn't even
support it.  This from discussions on the NetBSD forums a few years
back.  I wouldn't be surprised if the drive were reporting wrong
info....  From what I gather, Quantum's high end drives were pretty
decent, but I have a stack of dead Fireballs to prove that their low end
drives weren't....  :-|


Later,
David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
