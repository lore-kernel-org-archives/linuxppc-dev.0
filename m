Message-ID: <6058-40021@sneakemail.com>
Date: Wed, 07 Apr 2004 16:09:33 -0700
From: "Stephen Williams" <612dlag102@sneakemail.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: System ACE MPU interface to CF card
References: <407470ED.3030607@buckeye.ece.drexel.edu>
In-Reply-To: <407470ED.3030607@buckeye.ece.drexel.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sharad Gupta sharad-at-buckeye.ece.drexel.edu |PPC Linux Embedded| wrote:
>
> Hi All,
>
> I would like to know if anyone in the group or otherwise is/was using
> Xilinx's System ACE MPU interface to read/write to Compact Flash card on
> their hardware ? I see that there is a device driver provided by Xilinx
> for system ace mpu bus in the linux kernel tree (2.4.23). But, I dont
> see anyone actually implementing it in their design.

That would be me. I haven't yet submitted patches for my JSE
board, but if you look back to the last few weeks in this list,
you'll see plenty of messages with SystemACE in their subject.

Including a patch on 1 April 2004 to generalize the driver a
bit. MonteVista folks have approved the patch, so I hope it
turns up inofficial trees in due course.

--
Steve Williams                "The woods are lovely, dark and deep.
steve at XXXXXXXXXX           But I have promises to keep,
http://www.XXXXXXXXXX         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
