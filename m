Message-Id: <200003161408.JAA68227@p2.parker.boston.ma.us>
To: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
cc: gjohnson@research.canon.com.au (Greg Johnson),
        linuxppc-embedded@lists.linuxppc.org ( Linux PPC Mailing List)
Subject: Re: User buffers and cache flushing.
In-reply-to: Your message of "16 Mar 2000 11:07:10 +0100."
             <kfy3dprqldd.fsf@kieraypc07.p.y.ki.era.ericsson.se>
Date: Thu, 16 Mar 2000 09:08:46 -0500
From: Brad Parker <brad@parker.boston.ma.us>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Marcus Sundberg wrote:
>
>The right thing to do is allocate memory in the driver and allow
>the user process to mmap() it.
>

years ago the linux BT848 pci video driver did this.  it allocated a
huge (like 1mb) buffer and the userland app would mmap it and could
then do things to the video frames in (almost) real time...  I'll bet
the current generation 'video for linux' code has examples of this...

-brad

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
