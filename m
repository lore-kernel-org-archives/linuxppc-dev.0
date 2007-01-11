Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id EAD33DDDFB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Jan 2007 12:19:39 +1100 (EST)
To: "An Le Thien" <tieuphongit@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Can't start snmpd when adding notification handler to the
	configuration file
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 10 Jan 2007 22:33:50 +0700."
	<f2042b870701100733v20d7a052kca11f2ef0d108849@mail.gmail.com>
Date: Thu, 11 Jan 2007 02:19:37 +0100
Sender: wd@denx.de
Message-Id: <20070111011937.C0C9A35264F@atlas.denx.de>
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

In message <f2042b870701100733v20d7a052kca11f2ef0d108849@mail.gmail.com> you wrote:
> 
> 2. I used ELDK3.1.1 to build it and install to ramdisk that is used for
> TQM8xxL (Using kernel 2.6.11)

ELDK 3.x has been tested with  2.4  kernel  trees  only.  For  a  2.6
kernel, you should use ELDK 4.x.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Hiring experienced unix people is  like  a  built-in  filter  against
idiots. Hiring experienced NT people provides no such guarantee.
            -- Miguel Cruz in WgL96.349$CC.122704@typhoon2.ba-dsg.net
