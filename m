Message-ID: <3EA82D12.4010707@ecubics.com>
Date: Thu, 24 Apr 2003 12:29:38 -0600
From: emanuel stiebler <emu@ecubics.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: boot/simple in ROM?
References: <20030424123313.A8490@borg.org> <3EA81B3F.9080709@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:
 >
 > The old PPCBoot, and probably the new U-boot, kind of perform
 > some of these functions.  The reason I'm not a fan of doing this
 > is if we make a change to the Linux calling sequence (which happens
 > rarely) you also have to update the boot rom to match.  Not a good
 > thing, IMHO.

That's a very small price to pay for all the luxury of having a smarter
boot-monitor.

And, how many times was the linux calling sequence changed in the last
two years ?

cheers


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
