Return-Path: <wd@denx.de>
Received: from mailout09.sul.t-online.com (mailout09.sul.t-online.com
	[194.25.134.84]) by ozlabs.org (Postfix) with ESMTP id D519D2BEA0
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 Nov 2004 12:54:29 +1100 (EST)
To: "Mark Chambers" <markc@mail.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 05 Nov 2004 16:26:14 EST."
	<007d01c4c37e$17e8e0d0$0301a8c0@chuck2>
Date: Sat, 06 Nov 2004 01:52:43 +0100
Sender: wd@denx.de
Message-Id: <20041106005248.582C2C1430@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Handling power failure - MPC5200 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <007d01c4c37e$17e8e0d0$0301a8c0@chuck2> you wrote:
>
> So maybe, are you thinking that a power fail interrupt is a waste of
> time?  Just segment the file system as you suggested and trust the
> writeable part to jffs2?

A PF interrupt can be extremely useful - if it leaves you enough time
to do the things you want to  do.  If  all  you  got  is  50  or  100
milliseconfs  then you have little chance to avoid problems with a CF
card that is being written to. In such a case you  must  design  your
system such that it is robust enough even without such cleanup.

> Another technique that has fallen out of favor but is still useful in some
> applications is battery backed RAM.  It's relatively expensive, but if
> you want fast non-volatile memory it can't be beat.

It depends. Sometimes you may have a  battery,  and  the  power  fail
signal  is  just a warning that leaves you enough time for an orderly
shutdown.

Best regards,

Wolfgang Denk

-- 
See us @ Embedded/Electronica Munich, Nov 09 - 12, Hall A.6 Booth 513
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Humans do claim a great deal for that particular emotion (love).
	-- Spock, "The Lights of Zetar", stardate 5725.6
