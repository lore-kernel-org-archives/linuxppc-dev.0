Message-ID: <XFMail.990119132838.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <19990119081330.A10519@tiktok.cygnus.com>
Date: Tue, 19 Jan 1999 13:28:38 -0000 (GMT)
From: Gary Thomas <gdt@linuxppc.org>
To: Michael Meissner <meissner@cygnus.com>
Subject: Re: Booting 2.2.0-pre6 on a PowerStack-II (Net 4000/200)
Cc: Dan Malek <dmalek@jlc.net>, linuxppc-dev@lists.linuxppc.org,
        Alois Fertl <alois_fertl@mucmot.muenchen.europe.mcd.mot.com>,
        Johnnie Peters <jpeters@phx.mcd.mot.com>,
        Cort Dougan <cort@persephone.cs.nmt.edu>,
        Gary Thomas <gdt@linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 19-Jan-99 Michael Meissner wrote:
> On Tue, Jan 19, 1999 at 10:27:30AM -0000, Gary Thomas wrote:
>> 
>> On 18-Jan-99 Cort Dougan wrote:
>> > Please ship that to me and I'll stick it in.
>> > 
>> > I like Garbriels bootloader and I think it may be worthwhile to make the
>> > MBX/PReP bootloader break sometime soon.  A relocatable bootloader for
>> > prep would solve a lot of problems.
>> > 
>> > }I'll try upgrading to 2.2.0p7 tonight and see how that works.
>> > }
>> 
>> Attached are my changes to add [minimal] residual data to PreP booting.
>> I've also had to make some minor compatability changes to get extended
>> partitions to work with old disks.
> 
> I see you added changes to set the initial cmd config.  Is there any way we can
> add a configure line when building the kernel, so I can build a kernel with
> different data (ie, my disk is /dev/sda2 and not /dev/sdb2, etc.).  That way it
> has a better chance of working if rebooted in the middle of the night due to
> power failure.
> 

I like this idea.  I'll see what I can do with it tonight.

------------------------------------------------------------------------
Gary Thomas                              |
email: gdt@linuxppc.org                  | "Fine wine is a necessity of
   ... opinions expressed here are mine  |        life for me"
       and no one else would claim them! |
                                         |      Thomas Jefferson
------------------------------------------------------------------------



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
