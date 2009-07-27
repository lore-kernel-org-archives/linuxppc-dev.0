Return-Path: <wd@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 88840B6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jul 2009 04:32:01 +1000 (EST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id CB5E1DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2009 04:31:59 +1000 (EST)
To: Eddie Dawydiuk <eddie@embeddedarm.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: image/wrapper script questions
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <4A6DDF80.209@embeddedarm.com>
References: <4A6DDF80.209@embeddedarm.com>
Date: Mon, 27 Jul 2009 20:31:55 +0200
Message-Id: <20090727183155.7FA16832E416@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Eddie Dawydiuk,

In message <4A6DDF80.209@embeddedarm.com> you wrote:
> 
> I'm working on a custom board using an AMCC 440EP that is using a proprietary 
> bootloader(optimized for fast boot time). Currently our bootloader loads a 
> simpleImage.initrd into RAM and jumps into it. I originally chose to use a 
> simpleImage with an initial ramdisk embedded because it was the simplest 
> solution to debug the hardware and get a kernel and initial ramdisk running for 
> development. For production I would prefer to put the initial ramdisk on it's 

Hm... isn't that an oxymoron? Trying to optimize  for  speed  on  one
hand, and using an initrd which is one of the slowest ways to boot on
the other hand?

> Thanks for any suggestions :)

Use another file system (and another fstype) and separate it from the
kernel image.

See also http://www.denx.de/wiki/view/DULG/RootFileSystemSelection

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Computers are not intelligent.  They only think they are.
