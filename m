Return-Path: <ammubhai@gmail.com>
Received: from marmot.shef.ac.uk (marmot.shef.ac.uk [143.167.1.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D62B167C94
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Oct 2006 18:00:30 +1000 (EST)
Message-ID: <45236A0F.6000204@gmail.com>
Date: Wed, 04 Oct 2006 09:00:15 +0100
From: Ameet Patil <ammubhai@gmail.com>
MIME-Version: 1.0
To: Pradeep Sampath <pradeepsampath@yahoo.com>
Subject: Re: booting 2.6 kernel on ML403
References: <20061003214641.48214.qmail@web83210.mail.mud.yahoo.com>
In-Reply-To: <20061003214641.48214.qmail@web83210.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Pradeep Sampath wrote:
> Hi Ameet,
> Thanks for the instant reply. I changed root parameter to xsa as you 
> suggested root=/dev/xsa2. But i still get the same failure.
>  
> [    3.093694] TCP bic registered
> [    3.129458] NET: Registered protocol family 8
> [    3.181412] NET: Registered protocol family 20
> [    3.236744] VFS: Cannot open root device "xsa2" or unknown-block(0,0)
> [    3.313092] Please append a correct "root=" boot option
> [    3.375552] Kernel panic - not syncing: VFS: Unable to mount root 
> fs on unkno
> wn-block(0,0)
> [    3.474504]  <0>Rebooting in 180 seconds..
>
>  
> On the CF i created the following block and character device files
> # mknod -m 660 console c 5 1
> # mknod -m 660 xsa b 254 0
> # mknod -m 660 xsa1 b 254 1
> # mknod -m 660 xsa2 b 254 2
> # mknod -m 660 xsa3 b 254 3
> mkdir tts
> # mknod -m 660 0 c 4 64
>
> > Problem 2:
> > - Untar the kernel 2.6.17.1
> > - Applied the 5 TEMAC patches
> > - Applied Ameet's Sysace patch
> which patch did you apply? For TEMAC... apply the following patch:
> http://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linuxppc-2.6.17.1-sysace-1.2-after-TEMAC.patch
> Yes, i have applied *only* after-TEMAC.patch. But looks like it blows 
> away the configuration and results in kernel hang.
>  
> Any further suggestions on where i should look at.
>  
> regards.
> Pradeep
Please could send me all the boot messages until the point where it 
stops. This will help me better identify the problem.

Thanks,
-Ameet
