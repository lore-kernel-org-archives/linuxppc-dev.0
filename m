Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id C19D4DDF9E
	for <linuxppc-dev@ozlabs.org>; Sun, 24 May 2009 04:14:26 +1000 (EST)
To: Hunter Cobbs <hunter.cobbs@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: PPC405EX based irq flooding with USB-OTG and usbserial device
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <ad84a70a0905222048i4e7ae5ddp66418f96d531f5f3@mail.gmail.com>
References: <ad84a70a0905222048i4e7ae5ddp66418f96d531f5f3@mail.gmail.com>
Date: Sat, 23 May 2009 20:14:22 +0200
Message-Id: <20090523181422.794B3832E416@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Hunter,

In message <ad84a70a0905222048i4e7ae5ddp66418f96d531f5f3@mail.gmail.com> you wrote:
> 
> This is my first post to the PPC dev list as my company has just started
> developing a new project based on Linux.  The good news is, this post is not
> debug-related as much as it is an introduction and query while I download
> the latest DENX kernel(only place I know that has the DWC_OTG driver).

there is a strong reason why we decided  not  to  try  to  push  this
driver  upstream:  it  is not in a state that would have a chance for
being accepted for mainline. The problems you  are  experiencing  are
probably   not   the   only  one.  Please  consider  this  driver  as
unsupported.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Ada is PL/I trying to be Smalltalk.                 - Codoso diBlini
