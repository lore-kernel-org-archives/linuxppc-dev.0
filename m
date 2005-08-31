Return-Path: <wd@denx.de>
Received: from mailout09.sul.t-online.com (mailout09.sul.t-online.com
	[194.25.134.84]) by ozlabs.org (Postfix) with ESMTP id 0C398681C8
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Sep 2005 06:46:35 +1000 (EST)
To: Andrey Volkov <avolkov@varma-el.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 31 Aug 2005 19:50:52 +0400."
	<4315D1DC.1000607@varma-el.com>
Date: Wed, 31 Aug 2005 22:46:27 +0200
Sender: wd@denx.de
Message-Id: <20050831204627.EAF8C35258E@atlas.denx.de>
Cc: Sylvain Munaut <tnt@246tNt.com>, linuxppc-embedded@ozlabs.org
Subject: Re: [RFC] MPC5200 BestComm microcode [en]/[de]coding draft 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Andrey,

in message <4315D1DC.1000607@varma-el.com> you wrote:
> 
> Wolfgang, first question to you:
> May be you are know where I could find (if it exist)
> BestComm (SmartComm) API for mystic MGT5100?

We did not test the current code on the Icecube with  the  5100,  but
previous  versions  used to run fine (well, within the limitations of
the 5100, that is). So if the current code on our CVS server does not
run, just check out an oder version. You can search  the  history  of
changes for example here:
http://source.denx.net/cgi-bin/gitweb.cgi?p=linuxppc_2_4_devel.git
like that:
http://source.denx.net/cgi-bin/gitweb.cgi?p=linuxppc_2_4_devel.git&a=search&s=bestcomm

> Agree, good think. Wolfgang, is it appropriately to use WIKI of denx.de?

Yes, of course. Just let me know what you want and we  can  create  a
new web (I don't see any good existing place where this fits).

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"The number  of  Unix  installations  has  grown  to  10,  with  more
expected."    - The Unix Programmer's Manual, 2nd Edition, June, 1972
