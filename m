Message-ID: <3EA8035E.3040705@mail.utexas.edu>
Date: Thu, 24 Apr 2003 10:31:42 -0500
From: Chris Heintzelman <heintz@mail.utexas.edu>
MIME-Version: 1.0
To: Dale Farnsworth <dale@farnsworth.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: booting MGT5100?
References: <3EA70BDE.9080609@mail.utexas.edu> <20030424020846.GA1283@rover.farnsworth.org>
In-Reply-To: <20030424020846.GA1283@rover.farnsworth.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for the info!  I'm also using an icecube board.  I'll grab the
code from mv when you post it there.
Do you use a bootloader or do you just use dbug to run a zImage?

-Chris H.

>On Wed, Apr 23, 2003 at 09:55:42PM +0000, Chris Heintzelman wrote:
>
>
>>I noticed that a few months ago someone mentioned booting Linux on one
>>of these boards (MGT5100).  There didn't seem to be much discussion
>>though; I have one of these boards and would also like to boot linux on
>>it, I'm wondering if anyone can point me to a good starting point on
>>this?  Any help is appreciated.  I've got a toolchain and kernel built
>>but am having no luck with it.
>>
>>Thanks,
>>Chris H.
>>
>>
>
>I've been working with Kent Borg to bring up linux on the mgt5100.
>As Peter said, they're running it on an icecube, while I have a glacier
>system.  The serial driver seems reasonably solid.  I've been working
>on an ethernet driver and started testing it today.  It has sent and
>received a few packets but lots of cleanup remains.  I plan to put up a
>bk repository on source.mvista.com in a couple of weeks.  I could send
>you a tarball if you'd rather not wait.
>
>-Dale Farnsworth
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
