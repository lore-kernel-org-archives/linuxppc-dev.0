Return-Path: <frannk_m1@yahoo.com>
Message-ID: <20041024215018.26468.qmail@web13802.mail.yahoo.com>
Date: Sun, 24 Oct 2004 14:50:18 -0700 (PDT)
From: Frank <frannk_m1@yahoo.com>
To: Ryan Wilkins <ryan@elevated-networks.com>
In-Reply-To: <002D5C38-25FC-11D9-BA35-0050E4B0DC64@elevated-networks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.com
Subject: Re: MPC850 and GDB help
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I think I may have confused you a little. When I said running
u-boot from ram, I meant booting it from ram as if it had boot
from flash. Normally, at some point, u-boot _will_ run from ram
by copying itslef there and continung to run. But getting it to
run from ram it's reset vector (first linked address + 0x100) is
totally different.
I'm not sure what you mean by "running Linux from ram". Although
the kernel may reside in flash, it is at some point unzipped,
copied to ram and then runs from there. Someone on this list may
be able to help you more here. Maybe you will have beteer luck
then me getting an answer from these guys. They don't seem to
respond to my questions.:-(

--- Ryan Wilkins <ryan@elevated-networks.com> wrote:

> Thanks for the idea.  I'll check it out.
> 
> What about running the Linux kernel from ram?  Will I
> encounter the 
> same difficulties?
> 
> Thanks,
> Ryan Wilkins
> 
> On Oct 24, 2004, at 3:33 PM, Frank wrote:
> 
> > You probably want to post this to the u-boot users mailing
> > lists. Compiling and linking u-boot to run out of ram is not
> a
> > straight forward task. I've done it on more then one board,
> but
> > it is not easy if you're a u-boot novice.
> > Search the list for "running out of ram" or something like
> that
> > and you'll see what I mean.:-)
> 
> 



		
_______________________________
Do you Yahoo!?
Declare Yourself - Register online to vote today!
http://vote.yahoo.com
