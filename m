Return-Path: <wd@denx.de>
Received: from mailout07.sul.t-online.com (mailout07.sul.t-online.com
	[194.25.134.83]) by ozlabs.org (Postfix) with ESMTP id A822F2BF07
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Dec 2004 02:33:35 +1100 (EST)
To: "Srivatsan" <srivatsan@deccanetworld.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 28 Dec 2004 11:22:49 +0530."
	<000601c4eca1$786596f0$1269cb0a@bgcw301>
Date: Tue, 28 Dec 2004 16:33:10 +0100
Sender: wd@denx.de
Message-Id: <20041228153315.3EF4FC14EC@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Linux Kernel boot problem 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <000601c4eca1$786596f0$1269cb0a@bgcw301> you wrote:
> 
> When the Kernel is booted, it prints the following
> Uncompressing Linux.......done
> Now booting the kernel
>  
> The kernel hangs(or not detecting the console) after printing the above
> messages. Any pointers would be of great help to us.

See the FAQ section of the DULG, especially:

http://www.denx.de/twiki/bin/view/DULG/LinuxHangsAfterUncompressingKernel
http://www.denx.de/twiki/bin/view/DULG/LinuxPostMortemAnalysis

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Everyting looks interesting until you do it. Then you find it's  just
another job.                     - Terry Pratchett, _Moving Pictures_
