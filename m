Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id D9C92DDF72
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 May 2008 03:00:12 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JrFex-0003oA-6E
	for linuxppc-embedded@ozlabs.org; Wed, 30 Apr 2008 16:59:59 +0000
Received: from p5497e5e0.dip.t-dialin.net ([84.151.229.224])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 30 Apr 2008 16:59:59 +0000
Received: from dzu by p5497e5e0.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 30 Apr 2008 16:59:59 +0000
To: linuxppc-embedded@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: Predefined Compiler Flag for CROSS_COMPILE in ELDK
Date: Wed, 30 Apr 2008 18:59:05 +0200
Message-ID: <m2tzhjxorq.fsf@ohwell.denx.de>
References: <6e404418e8a1a19e1870eab8117c625e@lesc.ufc.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Rodolfo,

> I using ppc_4xx- cross-compiler for build linux in xup virtex II pro.
> How can I change -mpcu compiler flag for a specific vallue for my
> board/processor? 

Do the obvious thing - specify it on every command line.

Cheers
  Detlev

-- 
"Oh, didn't you know, the Lord did the original programming of the universe in
COBOL." - "That's why the world is the evil work of Satan. A true divine being
would have used Scheme."  -  "And, if so, Jesus would have been crucified on a
big lambda symbol."  -- K. Chafin, K. Schilling & D. Hanley, on comp.lang.lisp
--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
