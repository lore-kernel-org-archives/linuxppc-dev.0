Return-Path: <wd@denx.de>
Received: from mailout03.sul.t-online.com (mailout03.sul.t-online.com
	[194.25.134.81]) by ozlabs.org (Postfix) with ESMTP id DE93C67FD1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Aug 2005 06:49:51 +1000 (EST)
To: Vitaly Bordug <vbordug@ru.mvista.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 17 Aug 2005 21:24:57 +0400."
	<430372E9.7040700@ru.mvista.com>
Date: Wed, 17 Aug 2005 22:49:32 +0200
Sender: wd@denx.de
Message-Id: <20050817204932.D1C22353CE9@atlas.denx.de>
Cc: Kumar Gala <galak@freescale.com>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: ppc_sys SOC identification additions 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <430372E9.7040700@ru.mvista.com> you wrote:
>
> +	while (strcmp(ppc_sys_specs[i].ppc_sys_name, "")) {
...
> +	while (strcmp(ppc_sys_specs[i].ppc_sys_name, ""))
...
> +	while (strcmp(ppc_sys_specs[i].ppc_sys_name, "")) {

What about:

	while (ppc_sys_specs[i].ppc_sys_name[0]) ... ???

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
What we anticipate seldom occurs;  what  we  least  expect  generally
happens.                                          - Bengamin Disraeli
