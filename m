To: Dan Malek <dan@netx4.com>
cc: Daniel Wu <Daniel.Wu@alcatel.com.au>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Using zImage.initrd 
In-Reply-To: Message from Dan Malek <dan@netx4.com>
   of "Thu, 08 Jun 2000 22:52:43 -0400." <39405BFB.1E231721@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain
Date: Fri, 09 Jun 2000 13:59:01 +1000
Message-ID: <27181.960523141@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 08 Jun 2000 22:52:43 -0400, Dan Malek <dan@netx4.com> writes:
>Murray Jensen wrote:
>
>> Try this patch:
>>
>> --- fs/buffer.c 2000/05/16 01:31:41     1.1.1.12
>
>
>The 2.2.xx kernels don't have any ramdisk patch required.  This was
>broken in later 2.3.xx kernels.  Don't be trying this in 2.2 kernels.

It's not the ramdisk patch, just the simple check to ensure that the
"bdflush_tsk" variable is not NULL in wakeup_bdflush(). This patch should
be ok to try if you are getting a crash in __wake_up(). It may or may not
fix the problem, but it shouldn't hurt. Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@cmst.csiro.au  (old address was mjj@mlb.dmt.csiro.au)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
