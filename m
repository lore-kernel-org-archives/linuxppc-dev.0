Return-Path: <wd@denx.de>
Received: from mailout03.sul.t-online.com (mailout03.sul.t-online.com
	[194.25.134.81]) by ozlabs.org (Postfix) with ESMTP id 144A76856C
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Oct 2005 08:34:23 +1000 (EST)
To: somshekar chandrashekar kadam <som_kadam1@rediffmail.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "16 Oct 2005 12:53:38 -0000."
	<20051016125338.12386.qmail@webmail50.rediffmail.com>
Date: Mon, 17 Oct 2005 00:34:00 +0200
Sender: wd@denx.de
Message-Id: <20051016223400.E629C35265C@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: denx 3.1.1 eldk ramdisk_image 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20051016125338.12386.qmail@webmail50.rediffmail.com> you wrote:
> 
> now i am using ELDK 3.1.1 , and also us
> ing the ramdisk image provided by the ELDK ramdisk_image.gz , 
> and in ker
> nel i have configured for intial ramdisk support with size 4096 and for ext
> 2 file system , 
> it gives the message 
> 
> VFS kernel panic unable to mo
> unt root fs 01:00 

It certainly gives some more messages, which you did not  share  with
us. Also your kernel configuration is unknown to us.

So what do you expect? That we guess the casue of teh problem from  a
single line of output? I'm afraid it doesn't work like that.

Provide better information, and you might receive better advice.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
What is research but a blind date with knowledge?      -- Will Harvey
