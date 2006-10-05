Return-Path: <ammubhai@gmail.com>
Received: from marmot.shef.ac.uk (marmot.shef.ac.uk [143.167.1.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 48E7F67DC7
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Oct 2006 18:30:16 +1000 (EST)
Message-ID: <4524C290.3090702@gmail.com>
Date: Thu, 05 Oct 2006 09:30:08 +0100
From: Ameet Patil <ammubhai@gmail.com>
MIME-Version: 1.0
To: Pradeep Sampath <pradeepsampath@yahoo.com>
Subject: Re: booting 2.6 kernel on ML403
References: <20061004164721.22885.qmail@web83207.mail.mud.yahoo.com>
In-Reply-To: <20061004164721.22885.qmail@web83207.mail.mud.yahoo.com>
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

Pradeep,
   What you have pasted is only part of the messages displayed. I can't 
tell anything from this apart from you 'root=' option. It would be nice 
if you could paste the entire log of the boot messages right from 
'loaded at: xxxxxxx  xxxxxxxx' to 'Kernel Rebooting in 150 seconds'.

-Ameet

Pradeep Sampath wrote:
> Ameet,
>  
> loaded at:     00400000 0051513C
> board data at: 00513124 0051313C
> relocated to:  004050E8 00405100
> zimage at:     004057FD 0051230A
> avail ram:     00516000 04000000
> Linux/PPC load: console=ttyS0,9600 root=/dev/xsa2
> Uncompressing Linux...done.
> Now booting the kernel
>
>
> Please could send me all the boot messages until the point where it
> stops. This will help me better identify the problem.
>
> Thanks,
> -Ameet
>
>
