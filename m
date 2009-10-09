Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 7A1DDB70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Oct 2009 22:42:33 +1100 (EST)
To: Vineeth _ <blacklites@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: linux booting fails on ppc440x5 with SRAM
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <a9b543570910090320t1444f8f1qf4c8ab7dbbef679f@mail.gmail.com>
References: <a9b543570909230749g5bb9c302wa48f310250068f5b@mail.gmail.com>
	<1253742018.7103.333.camel@pasglop>
	<cb9ecdfa0910021017s5eece937ve7af90473d5a1a33@mail.gmail.com>
	<a9b543570910090320t1444f8f1qf4c8ab7dbbef679f@mail.gmail.com>
Date: Fri, 09 Oct 2009 13:33:38 +0200
Message-Id: <20091009113338.2B7E3E84EBC@gemini.denx.de>
Cc: Johnny Hung <johnny.hacking@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Vineeth _,

In message <a9b543570910090320t1444f8f1qf4c8ab7dbbef679f@mail.gmail.com> you wrote:
> We ported the uboot Memory test and tested the 15MB ram and it was
> successful.interestingly we have only 16MB SRAM in our board.We used 1

Such a memory test means nothing. The only thing you can learn from it
is that basic read and write accesses are working. You don;t get any
information about the behaviour for burst mode accesses from such a
test. See the FAQ at
http://www.denx.de/wiki/view/DULG/LinuxCrashesRandomly  and at
http://www.denx.de/wiki/DULG/UBootCrashAfterRelocation

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I mean, I . . . think to understand you, I just don't know  what  you
are saying ...                        - Terry Pratchett, _Soul Music_
