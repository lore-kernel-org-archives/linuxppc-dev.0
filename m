Message-ID: <8D7C5F56B409554D9D46AC22195807F3061D70@exchwenz01.dmcwave.co.nz>
From: Rod Boyce <rod_boyce@stratexnet.com>
To: "'David Woodhouse'" <dwmw2@infradead.org>,
	Gary Thomas <gary@mlbassoc.com>
Cc: j.murali@gdatech.co.in, linux-mtd@lists.infradead.org,
	linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: cfi probe for two different flash devices
Date: Tue, 7 Oct 2003 07:51:40 +1300 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In fact is was so easy that I went from knowing of the existence of the
MTD subsystem to booting a Linux kernel and file-system on a custom map
in 2 days. You MTD guys have done a fantastic job.

Regards,
Rod Boyce.

PS sorry for the wasted channel space but I had to say something.

> -----Original Message-----
> From: David Woodhouse [mailto:dwmw2@infradead.org]
> Sent: Tuesday, 7 October 2003 6:16 a.m.
> Subject: Re: cfi probe for two different flash devices
>
> On Mon, 2003-10-06 at 11:10 -0600, Gary Thomas wrote:
> > This question would be best asked of the MTD folks (cc'd), but I
> > think you'll need a customized "map" function that recognizes these
> > two FLASH device types and creates the appropriate MTD sub-devices
> > appropriately.
>
> What Gary said.
>
> If you poke around in drivers/mtd/maps you'll find useful examples of
> such, including how to concatenate them together into one logical MTD
> device and have a file system spanning them both, etc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
