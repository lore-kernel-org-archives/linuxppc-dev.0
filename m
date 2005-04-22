Return-Path: <wd@denx.de>
Received: from mailout08.sul.t-online.com (mailout08.sul.t-online.com
	[194.25.134.20]) by ozlabs.org (Postfix) with ESMTP id 734C667A67
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Apr 2005 08:26:16 +1000 (EST)
To: Eugene Surovegin <ebs@ebshome.net>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 22 Apr 2005 14:06:11 PDT."
	<20050422210610.GA9158@gate.ebshome.net>
Date: Sat, 23 Apr 2005 00:25:56 +0200
Sender: wd@denx.de
Message-Id: <20050422222601.35F18C1510@atlas.denx.de>
Cc: Paul Gortmaker <p_gortmaker@yahoo.com>, linuxppc-embedded@ozlabs.org
Subject: Re: Warm reboot on 826x targets 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20050422210610.GA9158@gate.ebshome.net> you wrote:
> 
> This is not relevant, because Linux doesn't use this "checkstop" 
> trick. It directly just jumps to U-Boot warm-reboot entry point.

Which is a bad design desicion, IMHO. If you want to reset  a  board,
you  should  really  RESET  it  (and  give all attached peripherals a
chance to get reset, too), instead of just assuming everything is  in
good shape an it's sufficient to just jump into some boot loader code
again.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Language shapes the way we think, and determines what we  can  think
about."                                                 - B. L. Whorf
