Date: Tue, 12 Feb 2002 20:55:57 -0500
Subject: Re: new G4 dual 1 gig is here - how to install?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v480)
Cc: linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.yellowdoglinux.com
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
In-Reply-To: <416D9C76-201E-11D6-BE69-0003938E434C@ivey.uwo.ca>
Message-Id: <D232876A-2024-11D6-A30D-0003938E434C@ivey.uwo.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

BTW: Are there any nice utilities to let me snoop through the OF device
tree under Mac OSX.  I know I can get DisplayName Registry to work under
MacOS 9.2 but would rather do my machine snooping under OSX if possible.

Thanks,

Kevin


On Tuesday, February 12, 2002, at 08:08 PM, Kevin B. Hendricks wrote:

>
> Hi,
>
> Okay my new G4 1 gig box has finally arrived after sitting in Canadian
> customs for close to 5 days for no real good reason.
>
> So I made the kernel changes Ben indicated and built a kernel (up not
> smp to start) and since everything is installed on a external scsi drive
> I tried the following:
>
> I simply unplugged the scsi chain and installed it on the new machine.
> I then held down the option key to get the menu and sure enough the nice
> linux disk icon showed in the of menu.
>
> When I select it I immediately get the prompt for linux, mac, or cdrom
> boot but as soon as I hit l for linux it recycles.
>
> Obviously it can find the script partion and show it to me but it can
> not seem to find yaboot or the root linux partition (on that same drive)
> so perhaps some internal of path is set somehow that differs from my old
> machine to my new machine.
>
> So what is the best way to get linux working on this thing.  Since
> kernel changes are needed to recognize the new 7455 chip, none of the
> canned installers from SuSE, or YellowDog will work, will they?
>
> Do I have to roll my own installer with the fixed kernel just to get
> linux going?  If so, how  do I go about rolling my own installer image
> from the kernel I have built with the 7455 code changes in place?
>
> Ideas anyone.   I really thought since my current installation in on
> external scsi that the option startup trick would work (and it does run
> the script but yaboot does not seem to get properly launched.
>
> Hope someone can help since I have to give my old machine to my wife
> soon (or she will lynch me) so I really want to get linux up on my new
> machine before my old machine goes to her.
>
> Any helpful hints would be greatly appreciated.
>
> Thanks,
>
> Kevin
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
