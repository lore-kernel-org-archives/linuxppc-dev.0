Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id F3B2D679EF
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 13 May 2006 23:47:32 +1000 (EST)
To: "tony" <hangtoo@163.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: how to mount /dev/ram0 to / 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 13 May 2006 14:21:56 +0800."
	<44657B5A.00FD1A.21222>
Date: Sat, 13 May 2006 15:47:30 +0200
Sender: wd@denx.de
Message-Id: <20060513134730.1FF493526CA@atlas.denx.de>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <44657B5A.00FD1A.21222> you wrote:
> 
> >Probably no part of your rc scripts did anything with the information
> >in /etc/fstab ...
> ------------------------>> 
> 	but,isn't it auto excuted? 

Who should "auto execute"  it  if  not  one  of  your  rc  scripts???
("execute"  being  a  bad  term, as the file is neither an executable
itself not any kind of script - it's just a config file).

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Alles Gescheite ist schon gedacht worden, man muﬂ nur versuchen,
es noch einmal zu denken.          -- Goethe, Maximen und Reflexionen
