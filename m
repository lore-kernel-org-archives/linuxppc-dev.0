Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 2E5FFDDF0E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Mar 2007 05:57:50 +1100 (EST)
To: Jan-Hinnerk Dumjahn <jan-hinnerk.dumjahn@arcor.de>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Problems with PHY on STK5200 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 01 Mar 2007 12:16:57 +0100."
	<200703011216.57611.jan-hinnerk.dumjahn@arcor.de>
Date: Thu, 01 Mar 2007 19:57:45 +0100
Sender: wd@denx.de
Message-Id: <20070301185745.254BB353C3A@atlas.denx.de>
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

In message <200703011216.57611.jan-hinnerk.dumjahn@arcor.de> you wrote:
> 
> I'm trying to compile a recent kernel from DENX "linuxppc_2_4_devel" for my 
> STK5200 using ELDK 3.1.1.

It should compile and run fine.

> It seems that the current kernel there is not configuring the PHY. It looks 
> like the link is configured for full-duplex (although it should be configured 
> half-duplex).

What makes you think it should be half duplex only?

> BTW: What is the normal way to reference a commit in a git-repository? I 
> haven't seen any revision numbers.

You specify the git commit ID.

> Can anybody explain what the driver should to? Or even better has some patch 
> to make it work?

The driver should work :-) And it certainly does for me.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Is not that the nature of men and women -- that the  pleasure  is  in
the learning of each other?
	-- Natira, the High Priestess of Yonada, "For the World is
	   Hollow and I Have Touched the Sky", stardate 5476.3.
