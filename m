Return-Path: <stonepine@126.com>
Received: from m5-142.126.com (m5-142.126.com [202.108.5.142])
	by ozlabs.org (Postfix) with SMTP id 9E51567F41
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Nov 2006 06:25:49 +1100 (EST)
Message-ID: <4561F9F2.8020706@126.com>
Date: Tue, 21 Nov 2006 02:54:42 +0800
From: Stephen Yee <stonepine@126.com>
MIME-Version: 1.0
To: Andrey Volkov <avolkov@varma-el.com>
Subject: Re: FYI:  SM5xx toolchain project berliOS registration
References: <452D0172.1010806@varma-el.com>
In-Reply-To: <452D0172.1010806@varma-el.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Stephen Yee <shyi@bmrtech.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,
  I want to make Voyager GX PCI Demo Board Ver.A(a PCI cards with
SiliconMotion SM501 chip) work on PPC 405ep board to support CRT
monitor, I have ported Andrey Volkov's SiliconMotion SM501 drivers to
2.6.17,  and I have modified the module parameter 'active_plane' to CRT,
but, I can't get anything from the CRT monitor, and the relative console
messages as following:

....
registered sm5xx-fb device
sm5xx_fb_enable_controller: Enabling CRT controller
Console: switching to colour frame buffer device 128x48
fb0: SM5xx CRT frame buffer device
.....

is Here a  successful  story  about using SM501 on PPC platform with
this driver?  and would you please give me some advices to drive this
devices?
Thanks in Advance.
Stephen.

Andrey Volkov wrote:

>Hi all,
>
>Yesterday I issued new SiliconMotion SM501 drivers
>project request to berlios, and receive
>approvement couple hours ago.
>
>So project home page is:
>
> http://developer.berlios.de/projects/sm5xx/
>
>Anyone who wants admin/write-access, please register with
>berlios and tell me your account.
>
>SVN will be activated in nearest hours.
>Berlios has direct shell access to your repos.
>So if there are any svn/CVS-dumps to import or any
>scripts to set up...
>
>The central mailing list
>
>	sm5xx-devel@lists.berlios.de
>
>will be active soon too.
>
>--
>Happy hacking ;),
>
>Andrey Volkov
>Varma Electronics Oy
>
>-------- Original Message --------
>Subject: BerliOS Developer Project Approved
>Date: Wed, 11 Oct 2006 12:49:58 +0200 (CEST)
>From: admin@berlios.de
>To: avolkov@varma-el.com
>
>Your project registration for BerliOS Developer has been approved.
>
>Project Full Name:  SM5xx Toolchain
>Project Unix Name:  sm5xx
>CVS Server:         cvs.berlios.de
>SVN Server:         svn.berlios.de
>Shell Server:       shell.berlios.de
>Web Server:         sm5xx.berlios.de
>
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
>  
>
