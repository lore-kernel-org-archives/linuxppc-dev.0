Return-Path: <marvin24@gmx.de>
Received: from mail.gmx.net (imap.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 33EDC2BDB5
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Jan 2005 01:09:27 +1100 (EST)
From: Marc Dietrich <marvin24@gmx.de>
To: Sebastian Heutling <sheutlin@gmx.de>
Date: Tue, 4 Jan 2005 15:04:56 +0100
References: <200412261435.13562.marc.dietrich@ap.physik.uni-giessen.de>
	<200501031326.34477.marvin24@gmx.de> <41DA7E7A.3070901@gmx.de>
In-Reply-To: <41DA7E7A.3070901@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200501041504.57588.marvin24@gmx.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [FYI] linux 2.6 still not working with PReP (ppc32)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hallo Sebastian,

Am Dienstag, 4. Januar 2005 12:31 schrieben Sie:
> Hello Marc,
>
> Marc Dietrich wrote:
> >Hi Christian,
>
> Erm ... I'm Sebastian ;-)

ah! - sorry Sebastian, to many confusion in the last time...

> I am using a 2.6.8 (I was too lazy to patch & compile a 2.6.9 and wanted
> to test 2.6.10 when it's (the sources) in debian/unstable).
>
> >Can you put a working zImage.prep somewhere on the web (<1.44 MB, so I can
> >write it to a floppy disk)?
>
> I will do that and tell you later where you can download it.

This may no longer be necessary, but see below.

Acording to your log, your scsi drive also fails later, but boots from ide 
(how did you managed to install the ide disks?).

I posted a message to linux-scsi describing this problem. I guess the sym2 
driver never worked on the PReP machines. I tried it also with 2.4 kernels. 

So to summerize it: No one has a working Powerstack with 2.6 kernel and 
booting from SCSI. I hope there will be some input from the scsi list.

> >How does your boot.log looks like?
>
> Attached it.
> Note that I use a Matrox MilleniumII gfx card and XFree4 runs fine
> (without any crash) since I got a 2.6 kernel running (although I am not
> using XFree because I use the Powerstack as a router/server which has no
> Monitor).

Yeah - I search so many times for a Millenium card on eBay. Now I got one for 
EUR 1.00 but  it is in Germany, while I'm in France now for holidays :-(
I also have a P9100 here, but it is not supported (yet?) under linux...

Greetings

Marc
