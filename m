Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id F02FADDEBF
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Jan 2007 06:43:13 +1100 (EST)
To: tran vanle <vantranbk@yahoo.com.au>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: ELDK4.0 net-snmp can not work with trapsink 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 03 Jan 2007 00:33:29 +1100."
	<732221.55876.qm@web33009.mail.mud.yahoo.com>
Date: Tue, 02 Jan 2007 20:43:10 +0100
Sender: wd@denx.de
Message-Id: <20070102194310.C2FFE353AF2@atlas.denx.de>
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

In message <732221.55876.qm@web33009.mail.mud.yahoo.com> you wrote:
> 
> I use net-snmp package in ELDK4.0 with board TQM8xxL .

Don't do that. ELDK 4.0 is based on and more or less requires  a  2.6
kernel tree. And the TQM8xxL boards are NOT supported in 2.6 yet.

> I config it 

And why don't you use the net-snmp package that comes  included  with
the  ELDK,  or  follow  the  documented  method  to build ELDK target
packages?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Disc space - the final frontier!
