Date: Wed, 13 Feb 2002 21:29:45 -0500
Subject: Re: new G4 dual 1 gig is here - how to install?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v480)
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.yellowdoglinux.com
In-Reply-To: <D232876A-2024-11D6-A30D-0003938E434C@ivey.uwo.ca>
Message-Id: <B58DFA00-20F2-11D6-B4A8-0003938E434C@ivey.uwo.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I found you can easily find OF paths under MacOSX by simply issuing the
following commands from Terminal.app under MacOSX

ioreg -l

It lists the class hierarchy for the io devices and includes the of
device tree info.

So using that I was able to determine the proper OF boot path for my
scsi card:

/pci@f2000000/ADPT,2930CU@13/@1:6,\\yaboot

So I booted into OF and simply tried it.

There is good news and bad news:

1. The good news is that it seemed to boot

2.  The bad news is that my ATI 7500 with my flat panel display simply
goes black so I can't tell exactly what is detected or not.

But I was able to login blindly and issue a proper shutdown command so
the kernel did boot properly at least to some extent.

I will try with an old VGA monitor I have to see if I can figure out
what is up.

So it looks like once we get past the DFP ATI 7500 issues, it should be
pretty easy for distributions to add support for the new PowerMacs quite
easily.

I will let people know when I actually get something working.

Thanks,

Kevin

On Tuesday, February 12, 2002, at 08:55 PM, Kevin B. Hendricks wrote:

> Hi,
>
> BTW: Are there any nice utilities to let me snoop through the OF device
> tree under Mac OSX.  I know I can get DisplayName Registry to work
> under MacOS 9.2 but would rather do my machine snooping under OSX if
> possible.
>
> Thanks,
>
> Kevin
>
>
> On Tuesday, February 12, 2002, at 08:08 PM, Kevin B. Hendricks wrote:
>
>>
>> Hi,
>>
>> Okay my new G4 1 gig box has finally arrived after sitting in Canadian
>> customs for close to 5 days for no real good reason.
>>
>> So I made the kernel changes Ben indicated and built a kernel (up not
>> smp to start) and since everything is installed on a external scsi
>> drive
>> I tried the following:
>>
>> I simply unplugged the scsi chain and installed it on the new machine.
>> I then held down the option key to get the menu and sure enough the
>> nice
>> linux disk icon showed in the of menu.
>>
>> When I select it I immediately get the prompt for linux, mac, or cdrom
>> boot but as soon as I hit l for linux it recycles.
>>
>> Obviously it can find the script partion and show it to me but it can
>> not seem to find yaboot or the root linux partition (on that same
>> drive)
>> so perhaps some internal of path is set somehow that differs from my
>> old
>> machine to my new machine.
>>
>> So what is the best way to get linux working on this thing.  Since
>> kernel changes are needed to recognize the new 7455 chip, none of the
>> canned installers from SuSE, or YellowDog will work, will they?
>>
>> Do I have to roll my own installer with the fixed kernel just to get
>> linux going?  If so, how  do I go about rolling my own installer image
>> from the kernel I have built with the 7455 code changes in place?
>>
>> Ideas anyone.   I really thought since my current installation in on
>> external scsi that the option startup trick would work (and it does run
>> the script but yaboot does not seem to get properly launched.
>>
>> Hope someone can help since I have to give my old machine to my wife
>> soon (or she will lynch me) so I really want to get linux up on my new
>> machine before my old machine goes to her.
>>
>> Any helpful hints would be greatly appreciated.
>>
>> Thanks,
>>
>> Kevin
>>
>>
>>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
