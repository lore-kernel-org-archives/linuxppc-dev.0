Return-Path: <krypton@ulrich-teichert.org>
Received: from arbas.nms.ulrich-teichert.org (i3ED6530A.versanet.de
	[62.214.83.10]) by ozlabs.org (Postfix) with ESMTP id CCECC2BF07
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Jan 2005 02:47:53 +1100 (EST)
Message-Id: <200501021538.j02Fc0Ld013444@arbas.nms.ulrich-teichert.org>
To: sven.luther@wanadoo.fr (Sven Luther)
Date: Sun, 2 Jan 2005 16:38:00 +0100 (MET)
In-Reply-To: <20050101165758.GA18559@pegasos> from "Sven Luther" at Jan 01,
	2005 05:57:58 PM
From: Ulrich Teichert <krypton@ulrich-teichert.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Ulrich Teichert <krypton@ulrich-teichert.org>, linuxppc-dev@ozlabs.org,
	mikemartin@linux.ca, debian-powerpc@lists.debian.org
Subject: Re: 43p-140 install issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

[del]
>Yes, please, i would greatly appreciate it, preferably the 2.6.8 kernel too.
>Let' try to get this fixed before the sarge release, which is not so far off
>now.

OK, 9 hours later I had a current sarge buisnesscard CD image, with
interesting results. I booted the standard kernel from the cdrom
with `boot cdrom:`, it came up and failed to load the initrd, so it died
on the spot as nothing could be mounted. It was detecting that I was using
a serial console.
Of course, I forgot to capture that session, so I did it again with logging
on in kermit. Then I could not boot anything from the CD, but I can still
boot fine from disk, so it's not a hardware problem. The LED displays F05
after reading something from the CDROM in this case and the machine hangs.
Strange.

I will try to boot via tftp, the firmware seems to be unable to boot
a specific file from CDROM,

CU,
Uli
-- 
Dipl. Inf. Ulrich Teichert|e-mail: Ulrich.Teichert@gmx.de
Stormweg 24               |listening to: Suicide Drive (The Deep Eynde)
24539 Neumuenster, Germany|Public Pervert (Interpol) Clé De Contact (Metal Urbain)
