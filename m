Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 42D7ADDF4F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Apr 2007 10:14:03 +1000 (EST)
To: "JSL" <hsr_jsl@mail.tele.dk>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Serial console via SCC2 on Mpc8xx 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 25 Apr 2007 21:17:18 +0200."
	<00bc01c7876e$57a60980$6501a8c0@KontorPC>
Date: Thu, 26 Apr 2007 02:14:03 +0200
Sender: wd@denx.de
Message-Id: <20070426001403.82124352676@atlas.denx.de>
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

In message <00bc01c7876e$57a60980$6501a8c0@KontorPC> you wrote:
> 
> Has anyone had success with SCC2 as serial console instead of SMC1/2

Yes.

> uart. Has not yet found any Linux that have support for that when
> lokking at Linux 2.6 or 2.4 for MPC860P

Our 2.4.25 kernel tree supports serial console on any of the SMC1...2
and SCC1...4 ports (at least on the boards that support that).

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Accident: A condition in which presence of mind is good, but  absence
of body is better.
