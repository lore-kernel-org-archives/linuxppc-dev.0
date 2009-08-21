Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 04744B7B61
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 23:17:27 +1000 (EST)
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by ozlabs.org (Postfix) with ESMTP id 7F30CDDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 23:17:24 +1000 (EST)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1MeTzW-00024O-7V
	for linuxppc-dev@ozlabs.org; Fri, 21 Aug 2009 15:17:14 +0200
Received: from p4ff049b0.dip.t-dialin.net ([79.240.73.176])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 15:17:14 +0200
Received: from dzu by p4ff049b0.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 15:17:14 +0200
To: linuxppc-dev@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: 832x: MATH_EMUL
Date: Fri, 21 Aug 2009 15:16:51 +0200
Message-ID: <m2k50x8fy4.fsf@ohwell.denx.de>
References: <4A8E4128.6040905@denx.de>
	<1059A1F2-B4AA-48DC-82D6-B26D39414FA4@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kumar,

> On Aug 21, 2009, at 1:39 AM, Heiko Schocher wrote:
>
>> Hello,
>>
>> I actually porting a mpc8321 based port, and because there is no FPU
>> on this CPU, I activated MATH_EMUL, as all other mpc832x ports did.
>>
>> Is there something like a counter, which counts how many times this
>> Exception occurs?
>
> Geert published some patches that did something like this but there
> isn't upstream as far as I know at this point.

Were there any technical reasons or did it just slip into the cracks?
In my opinion such a counter would be *very* helpful to judge the
performance impact one suffers instead of living in ignorant bliss.

Cheers
  Detlev

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
