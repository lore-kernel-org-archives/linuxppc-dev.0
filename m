Return-Path: <annamaya@yahoo.com>
Received: from web53808.mail.yahoo.com (web53808.mail.yahoo.com
	[206.190.36.203]) by ozlabs.org (Postfix) with SMTP id E81862BD9F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Oct 2004 07:19:01 +1000 (EST)
Message-ID: <20041011211859.70484.qmail@web53808.mail.yahoo.com>
Date: Mon, 11 Oct 2004 14:18:59 -0700 (PDT)
From: annamaya <annamaya@yahoo.com>
To: Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20041011184705.GD6871@smtp.west.cox.net>
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

I do not have any other logs when this happens since I
dont have any serial output when the failure happens.
I am trying to do this on a EP8280 eval board. Has
someone already included support for this board in the
Kernel? Thank you.

--- Tom Rini <trini@kernel.crashing.org> wrote:

> On Mon, Oct 11, 2004 at 11:38:28AM -0700, annamaya
> wrote:
> 
> > Oops! Thanks for pointing that blooper. I am so
> used
> > to dealing with the U-Boot header of 64 bytes that
> I
> > misread the ELF header size as 64 bytes instead of
> 64
> > KBytes. 
> > 
> > Anyways, it looks like I am much farther that I
> have
> > ever been before. Now, I see that the PC is stuck
> at
> > some address that I am not sure what to make off.
> Is
> > this before the MMU has been turned on? Also, it
> looks
> > like my BDI is not showing the "Debug entry cause"
> > correctly.
> 
> Could you send more of the boot-log ?  And what
> board is this exactly on
> what kernel?  Thanks.
> 
> -- 
> Tom Rini
> http://gate.crashing.org/~trini/
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
