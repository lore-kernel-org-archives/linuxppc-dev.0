Date: Fri, 12 Oct 2001 15:02:57 -0700
Subject: Re: no luck with Adaptec SCSI controller in 2.4.X
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v472)
Cc: gibbs@scsiguy.com, linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.yellowdoglinux.com
To: mlan@cpu.lu
From: "David A. Gatwood" <dgatwood@apple.com>
In-Reply-To: <200110122006.WAA00806@piglet.grunz.lu>
Message-Id: <E4D88A21-BF5C-11D5-A238-003065B90BBC@apple.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Friday, October 12, 2001, at 01:06 PM, Michel Lanners wrote:

> On  12 Oct, this message from David A. Gatwood echoed through
> cyberspace:
>> From what I gather, Quantum's high end drives were pretty
>> decent, but I have a stack of dead Fireballs to prove that their low
>> end
>> drives weren't....  :-|
>
> I can add one to your stack, a 1.2 Gig originally from my 7600/132. Took
> the Debian install on my Performa 475 with it when half of the disk
> surface went unreadable.

Same here, only a 7600/120.  Thankfully, in my case, the bad blocks
first appeared in swap space, causing a kernel panic, which set off a
million red flags, so that very night, I backed everything up onto a 9
gig seagate and started using that as the main drive.

I left that Quantum drive in the machine as a backup.  A month later, I
tried accessing it, and it returned "DRIVE FAIL".  After a reboot a few
weeks later, the drive sounded like a chainsaw.  :-)


Later,
David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
