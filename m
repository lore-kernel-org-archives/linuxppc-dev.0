From: "Ira K. Weiny" <iweiny@kdat.csc.calpoly.edu>
Message-Id: <199907302109.OAA02303@kdat.csc.calpoly.edu>
Subject: How DOES OF Work? (ie multi-OS woes)
To: linuxppc-dev@lists.linuxppc.org
Date: Fri, 30 Jul 1999 14:09:05 -0700 (PDT)
Cc: linuxppc-user@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> I am curious: Has anyone ever compared the actual booting times for OF
>> booting and BootX booting (I can't, because my 6400 doesn't OF boot
>> anymore). I suspect the difference is less than 10 seconds. On a total
>> booting time of more than 60 seconds, this is really minimal.
>> 
>> I just rebooted, and the total time of 110 seconds (from typing "reboot"
>> until the login prompt) was spent as follows:
>> 
>> 35 sec: shutdown
>> 23 sec: starting MacOS and BootX extension, hitting the button, waiting
>> for the  
>>         penguin to show up and the kernel messages to start scrolling by
>> 52 sec: rest of linux boot procedure.


> I upgraded a PowerMac 8500 based PPC target system to YDL-1.0 and
> compared the boot times last week. My findings make a rather strong
> argument for OF booting: while BootX booting (using MacOS 8.6) takes about
> 30 secs, the kernel is loaded and started from OF in typically 3 seconds


I think the other side really is for those who don't want to boot the MacOS
at all.  I have had LinuxPPC for 2 years now booting from OF and I almost
got rid of my MacOS partition long ago but thought the best of it.  Now that
I have R5 I am glad I could at least use MacOS to get it installed but I
would still like to have a solution where I would not NEED the MacOS to
boot.

Furthermore, beyond having multiple OS's like NetBSD and BeOS I still have
my OLD release of LinuxPPC.  It is WAY older than even R4 and the only way I
have of booting it is through OF.  

I think the general concensus on this issue is the USERS want BootX or
something easy while the Developers and "Power Users," if you will, want to
have the flexibility of OF.

Anyway it is just my humble opinion that both should be supported.  However,
as a USER hoping to be a "Power User" and even devloper some day, I would
like to see some documentation on how to use OF to boot R5, ANY URL's?

My main question is "HOW THE HECK DOES OF WORK?"

Ira Weiny
iweiny@acm.org


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
