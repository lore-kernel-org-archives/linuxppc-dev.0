Date: Tue, 04 Apr 2000 09:49:47 -0700
From: Tim Wojtulewicz <Tim.Wojtulewicz@NAU.EDU>
Subject: Re: Install on a Pismo (going bad)
In-reply-to: <20000404125036.E31973@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Message-id: <p04310100b50fcd6dd346@[134.114.15.89]>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
References: <p04310100b50f59297908@[134.114.15.89]>
 <20000404125036.E31973@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>On Tue, Apr 04, Tim Wojtulewicz wrote:
>
>>
>>  I've run into a few problems with installing LinuxPPC 2000 on a Pismo
>>  powerbook.  First, the keyboard isn't recognized by the installer.
>>  I've tried hooking up a USB keyboard from a blue and white G3, but it
>>  says that the device wasn't responding and that is was giving up.  Is
>>  there a workaround of some sort for this?
>>
>>  Second (the more major problem), is that somehow the partition table
>>  on my hard drive got all screwed up.  Now the LinuxPPC installer
>>  tells me it can't read the partition table, and doesn't understand
>>  where my hard drive is.  I tried booting back into MacOS and using a
>>  multitude of tools to reformat the drive (or just recreate the
>>  partition table), with no luck.  Any suggestions?
>
>Boot from the MacOS CD, use Drive Setup, create one big MacOS partition,
>this will/should clean up the partition table. Then create 4 partitions,
>one for MacOS, one Linuxboot partition in HFS Format, one swap and a
>Linux Partition.
>Try the latest Kernel from Ben or our suseboot.hqx file at
>ftp://ftp.suse.com/pub/suse/ppc/update/BETA
>
>Finally, send me the output of
>ftp://ftp.suse.com/pub/suse/ppc/update/BETA/suse_hw_info.sh.
>Thanks.
>
>
>Gruss Olaf
>
>--
>  $ man 1 current_release
>
>BUGS
>        Users never read manuals...
>

I've come to the decision that the hard drive is fried :(.  I've
tried formatting the drive with Drive Setup and it returns
Initialization Failed every time.  I'm glad I bought the 3 year
warranty now.

Tim
--

-------
Tim Wojtulewicz           Tim.Wojtulewicz@nau.edu
(520)523-2543             http://dana.ucc.nau.edu/~tjw4

In the Windows world, you are one click away from
harming yourself -- Elias Levy, Bugtraq

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
