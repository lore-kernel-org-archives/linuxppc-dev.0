Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp10.wanadoo.fr (smtp10.wanadoo.fr [193.252.22.21])
	by ozlabs.org (Postfix) with ESMTP id 86F1F2BF11
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Jan 2005 03:33:51 +1100 (EST)
Date: Sun, 2 Jan 2005 17:41:22 +0100
To: Ulrich Teichert <krypton@ulrich-teichert.org>
Message-ID: <20050102164122.GA6866@pegasos>
References: <20050101165758.GA18559@pegasos>
	<200501021538.j02Fc0Ld013444@arbas.nms.ulrich-teichert.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200501021538.j02Fc0Ld013444@arbas.nms.ulrich-teichert.org>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev@ozlabs.org, mikemartin@linux.ca,
	debian-powerpc@lists.debian.org
Subject: Re: 43p-140 install issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jan 02, 2005 at 04:38:00PM +0100, Ulrich Teichert wrote:
> Hi,
> 
> [del]
> >Yes, please, i would greatly appreciate it, preferably the 2.6.8 kernel too.
> >Let' try to get this fixed before the sarge release, which is not so far off
> >now.
> 
> OK, 9 hours later I had a current sarge buisnesscard CD image, with
> interesting results. I booted the standard kernel from the cdrom
> with `boot cdrom:`, it came up and failed to load the initrd, so it died
> on the spot as nothing could be mounted. It was detecting that I was using
> a serial console.

You need to boot install/powerpc/vmlinuz-prep.initrd, not the vmlinux one.

> Of course, I forgot to capture that session, so I did it again with logging
> on in kermit. Then I could not boot anything from the CD, but I can still
> boot fine from disk, so it's not a hardware problem. The LED displays F05
> after reading something from the CDROM in this case and the machine hangs.
> Strange.
> 
> I will try to boot via tftp, the firmware seems to be unable to boot
> a specific file from CDROM,

Ah, strange. That said, tftp is the prefered boot method for prep hardware.

Friendly,

Sven Luther
