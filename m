Return-Path: <annamaya@yahoo.com>
Received: from web53810.mail.yahoo.com (web53810.mail.yahoo.com
	[206.190.36.205]) by ozlabs.org (Postfix) with SMTP id 1E7BD2BD6A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Oct 2004 03:33:46 +1000 (EST)
Message-ID: <20041011173344.62221.qmail@web53810.mail.yahoo.com>
Date: Mon, 11 Oct 2004 10:33:44 -0700 (PDT)
From: annamaya <annamaya@yahoo.com>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <079593FC-1BA4-11D9-A165-003065F9B7DC@embeddededge.com>
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

Dan,
First let me thank you for still being around to
answer questions for people like me. You helped me out
a lot a few years ago when I was just starting to work
on all the embedded stuff. I am glad you are still
helping everyone else.

I will try the zImage trick but I just wanted to know
if the assumption here is that the kernel already
understands the EEPROM data format to construct
bd_info. Is that correct? If the kernel is unable to
get to this data, is there another way to pass this
info to the kernel?

Thanks much.

--- Dan Malek <dan@embeddededge.com> wrote:

> 
> On Oct 11, 2004, at 12:04 PM, annamaya wrote:
> 
> > I am trying to boot a linux kernel using a
> PlanetCore
> > BootLoader on an embedded planet board. I am used
> to
> > always using U-Boot for my Kernel booting needs. I
> am
> > not sure how to get this going on a PlanetCore
> boot
> > loader.
> 
> You need to build a zImage so you get the simple
> bootloader that will read the information from the
> EEPROM
> and format the board structure.
> 
> Load the zImage file as a binary.  It has a 64K ELF
> header
> on it, so you can either use 'dd' to strip that
> before the
> download or add 64K to the load address to use as
> the
> start address.  The start address is the first
> instruction of
> the image (or +64K if you didn't remove the ELF
> header).
> 
> 
> 	-- Dan
> 
> 



		
__________________________________
Do you Yahoo!?
Yahoo! Mail Address AutoComplete - You start. We finish.
http://promotions.yahoo.com/new_mail 
