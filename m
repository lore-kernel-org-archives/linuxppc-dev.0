Message-ID: <3BDDE9F9.5060902@mvista.com>
Date: Mon, 29 Oct 2001 15:44:57 -0800
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Hans Johnson <hjohnson@sfu.ca>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on an NCD X Terminal?
References: <C9448467-CCC3-11D5-9A1D-0030655A0600@sfu.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hans Johnson wrote:

 >
 > Hi Folks,
 >
 > Just wondering if anyone has attempted a port of PPC Linux to the NCD
EXplora X Terminals? I just picked one up cheap ($10) and upon opening
 > it up, discovered that it seems to be constructed out of essentially
 > standard components.
 >
 > it has a PPC 403GCX CPU, an S3 Trio64 video chipset, an AMD PCNet fast
 > ethernet chipset, and a National Semiconductor I/O controller.  I'm not
 > sure what it has for a PCMCIA controller, but it does have a slot.
 >
 > Anyway, just curious if has attempted this before. I think this could be
 > a really neat little box, if it had an operating system. :)
 >

I happen to have one on my desk:)  I have not tried to boot linux on it
yet.  The 403 code is in the latest _devel kernel

 > > EXplora X Terminals? I just picked one up cheap ($10) and upon
 > opening it up, discovered that it seems to be constructed out of
 > essentially standard components.
 >
 > it has a PPC 403GCX CPU, an S3 Trio64 video chipset, an AMD PCNet
 > fast ethernet chipset, and a National Semiconductor I/O controller.
 >   I'm not sure what it has for a PCMCIA controller, but it does
 > have a slot.
 >
 > Anyway, just curious if has attempted this before. I think this
 > could be a really neat little box, if it had an operating system. :)
 >

I happen to have one on my desk:)  I have not tried to boot linux on it
yet.  The 403 code is in the latest _devel kernel.  It *should* work but
I haven't tested it lately.  Let me know if it works.

btw, the PCMCIA seems to be a custom pld.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
