Message-ID: <36EE719D.EF7C5C6D@phx.mcd.mot.com>
Date: Tue, 16 Mar 1999 07:58:37 -0700
From: Johnnie Peters <jpeters@phx.mcd.mot.com>
MIME-Version: 1.0
To: Cort Dougan <cort@ppc.kernel.org>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: new bootloader
References: <Pine.LNX.3.96.990316032305.21674A-100000@persephone.cs.nmt.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Cort,

I have it running.  I had some troubles with 2.2.2.  The SCSI system tended
to lock up after awhile but this seems to be gone on 2.2.3.  The only thing
I have so far noticed is that when compiled with SMP enabled, the 2.2.2
release hung during semaphore handling in the SCSI driver and in 2.2.3 it
panics at the same place.  I traced it down that far but have not had the time
to
go further.

I was glad to see that you have merged in the open firmware changes from
Gary Thomas.  I am finally preparing a patch of all the stuff I have been
doing
and will get that to you today.

Johnnie



Cort Dougan wrote:

> Has anyone tried it yet?  I haven't had any complaints and it's hard to
> believe it works for everyone as it is now.
>
> If you haven't tried it and were having trouble before please do give it a
> test.  Even if you can't give me patches for your hardware a quick
> description of the problem will help me get things in position to work
> sooner.




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
