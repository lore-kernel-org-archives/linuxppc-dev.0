Return-Path: <annamaya@yahoo.com>
Received: from web53807.mail.yahoo.com (web53807.mail.yahoo.com
	[206.190.36.202]) by ozlabs.org (Postfix) with SMTP id 1D7512BD9F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Oct 2004 08:52:50 +1000 (EST)
Message-ID: <20041011225248.55513.qmail@web53807.mail.yahoo.com>
Date: Mon, 11 Oct 2004 15:52:48 -0700 (PDT)
From: annamaya <annamaya@yahoo.com>
To: Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20041011214432.GB8121@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Booting Linux using a PlanetCore BootLoader
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am using the Linux Kernel 2.4.24-pre2. I included
support for this board and created an embed_config()
routine to pass in the correct board information. I am
now able to see the "relocation" messages by zImage
and it now halts with the message "Now booting the
kernel". I see that it is now hung in some delay
routine which was called from a panic routine. I am
working on trying to figure this out.

>go 210000

loaded at:     00210000 002D426C
relocated to:  00400000 004C426C
board data at: 004C1130 004C115C
relocated to:  004052D8 00405304
zimage at:     00405810 004C0CC4
avail ram:     004C5000 10000000

Linux/PPC load: root=/dev/nfs rw ip=on
Uncompressing Linux...done.
Now booting the kernel



--- Tom Rini <trini@kernel.crashing.org> wrote:

> On Mon, Oct 11, 2004 at 02:18:59PM -0700, annamaya
> wrote:
> 
> > I do not have any other logs when this happens
> since I
> > dont have any serial output when the failure
> happens.
> > I am trying to do this on a EP8280 eval board. Has
> > someone already included support for this board in
> the
> > Kernel? Thank you.
> 
> Without knowing which kernel you're using, I can't
> say for certain, but
> would assume it should work.  When you type 'go
> 0x210000' after loading
> the kernel, you get nothing?
> 
> -- 
> Tom Rini
> http://gate.crashing.org/~trini/
> 



		
_______________________________
Do you Yahoo!?
Declare Yourself - Register online to vote today!
http://vote.yahoo.com
