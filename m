Message-ID: <38A10693.C75820F4@netx4.com>
Date: Wed, 09 Feb 2000 01:17:55 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Stuart <stu@asyn.com>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Hostname problems
References: <000501bf728d$d717f550$0100000a@asyn.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stuart wrote:
>
> Hi all.
> What's the status on the 860 port in the 2.3.x tree from kernel.org.
> Specifically I'm working with an MBX box.

The 2.3.xx tree for the 8xx is pretty bad.  There are some updates
I want to incorporate, but I have been tracking down all of the
changes that cause 8xx not to build or boot properly.

For the MBX in particular, the support of the PC-style I/O has
finally been broken.  The support of the IDE was always a problem
because of the desire to use PCMCIA flash, the QSpan never seemed
to pass interrupt correctly, and now generic kernel changes finally
broke the indirect access to the 8259 (and I am still puzzled how
it is supported on other PMacs.....).

Anyway, those are some of the things I am working on.  There are
many other little things, like building without PCI configured
doesn't work either.  The last working 2.3.xx kernel I used and
updated was 2.3.18.

I am actively working on all of these because I want to make
sure we have a solid 8xx configuration when 2.4.x hits.

I will make an announcement when I get something stable again.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
