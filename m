Message-Id: <199906102114.XAA00319@piglet.cpu.lu>
Date: Thu, 10 Jun 1999 23:14:51 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Q: control is a C&T 65550?
To: drow@false.org
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <19990608101236.A5738@drow.res.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   8 Jun, this message from Daniel Jacobowitz echoed through cyberspace:
> 
> On Tue, Jun 08, 1999 at 04:00:48PM +0200, Geert Uytterhoeven wrote:
>> On Tue, 8 Jun 1999, Daniel Jacobowitz wrote:
>> > On Tue, Jun 08, 1999 at 07:51:39AM -0400, Jason Y. Sproul wrote:
>> > > Is it correct that the /chaos/control chip is essentially a Chips &
>> > > Technologies 65550? If so, does anyone have the variances from the 65550
>> > > datasheet, and if not, what the heck is it? :^)
>> > 
>> > It's my understanding that it's not.  No one has any documentation on
>> > it to my knowledge... I'd love to add hardware cursor support, which
>> > I'm fairly sure it has, to controlfb.  But I can't do it without some
>> > sort of reference.
>> 
>> Move the cursor under MacOS and see which registers or video memory addresses
>> change?
> 
> That's one of those if-i-had-more-time things - and more specifically,
> if I knew how to dump video regs under macos.  Is it trivial?

Not with my favourite tool: MacsBug. Problem is that MacsBug includes
some kind of control driver, that is able to switch control into its
own mode, preserving the original VRAM contents from MacOS... except
the cursor, of course. So, when you look at control's registers with
MacsBug, you see MacsBug's values, not MacOS'.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
