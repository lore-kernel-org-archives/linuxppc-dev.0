Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by bilbo.ozlabs.org (Postfix) with ESMTP id BFE83B7B6B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 14 Aug 2009 21:33:06 +1000 (EST)
To: "Olivier Croset" <olivier.croset@actis-computer.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [SATA] Does SATA work with kernel > v2.6.25.7?
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <AA253FF7C15741BCAE4B5D4B4FFF16B6@Labo5>
References: <AA253FF7C15741BCAE4B5D4B4FFF16B6@Labo5>
Date: Fri, 14 Aug 2009 13:33:00 +0200
Message-Id: <20090814113300.67F4D833DBD2@gemini.denx.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear "Olivier Croset",

In message <AA253FF7C15741BCAE4B5D4B4FFF16B6@Labo5> you wrote:
> 
> While browsing the web, I found the following message with the same kind of
> errors:
> http://linux.derkeiler.com/Mailing-Lists/Kernel/2009-03/msg08159.html
> 
> It is said that "the sata is only supported up to 2.6.25.7". Is it true for
> all PowerPCs or only for 460EX CPU?

This messages is explicitly about (and only  about)  the  AMCC  460EX
Canyonlands board and the Synopsys DesignWare Cores (DWC) SATA driver
used on this processor.

This has nothing to do with your poblems with a SIL controller.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
When all is said and done, more is said than done.
