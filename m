Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 9717FDDD0D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Sep 2007 07:16:40 +1000 (EST)
To: "Murat Artun" <artunmurat@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: changing the EDLK components
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 27 Sep 2007 17:34:04 +0300."
	<4e5a3720709270734k54016e93h68ae6606d959cee9@mail.gmail.com>
Date: Thu, 27 Sep 2007 23:16:35 +0200
Sender: wd@denx.de
Message-Id: <20070927211635.1CA6E2405D@gemini.denx.de>
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

In message <4e5a3720709270734k54016e93h68ae6606d959cee9@mail.gmail.com> you wrote:
> 
> Specifically, I have followed the procedure in section "3.7.
> Rebuilding ELDK Components". First I have installed source RPMs and
> then rebuilt the binary target RPM. However, as I have followed the
> compiler messages I recognized that host gcc is called instead of
> cross gcc.
> 
> Considering that my PATH was set following the advice in section "3.7.
> Rebuilding ELDK Components" as "<ELDK_root>/usr/ppc-linux/bin"
> directory is before "/usr/bin" what could be the problem?

If you really followed that advice then please explain how the native
gcc could be called at all because the cross compiler will always  be
found first in the PATH?

I recommend checking the documentation again and following it step by
step.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"This is a test of the Emergency Broadcast System. If this had been an
actual emergency, do you really think we'd stick around to tell you?"
