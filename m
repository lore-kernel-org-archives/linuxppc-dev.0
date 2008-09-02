Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 25C4DDDF1F
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Sep 2008 23:37:32 +1000 (EST)
To: "VenkataKrishna" <venkatakrishnap@vrindatech.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: How work ELDK4.0 in linux
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <20080902054341.2AFF7DDD0B@ozlabs.org>
References: <20080902054341.2AFF7DDD0B@ozlabs.org>
Date: Tue, 02 Sep 2008 15:37:30 +0200
Sender: wd@denx.de
Message-Id: <20080902133730.10EF72489D@gemini.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear "VenkataKrishna",

In message <20080902054341.2AFF7DDD0B@ozlabs.org> you wrote:
> 
> I installed ELDK 4.0 in linux host system. Now I want to develop linux BSP
> for my target Board (MPC8260) free scale. Any one suggest me How to works
> and sequence of compiling linux BSP.

	$ export CROSS_COMPILE=ppc_82xx-
	$ export ARCH=powerpc
	$ make <your_board_name>_defconfig
	$ make uImage

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
If the hours are long enough and the pay  is  short  enough,  someone
will say it's women's work.
