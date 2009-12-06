Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 6231AB7C08
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  6 Dec 2009 20:17:46 +1100 (EST)
To: Rolf Offermanns <roffermanns@sysgo.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: TQM5200 + SM501 FB
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <F5B2E7AE-A0C5-4D9B-AF8F-3158B94D6236@sysgo.com>
References: <20091204220426.ADD063F6E3@gemini.denx.de>
	<F5B2E7AE-A0C5-4D9B-AF8F-3158B94D6236@sysgo.com>
Date: Sun, 06 Dec 2009 10:17:42 +0100
Message-Id: <20091206091742.D4945E34A46@gemini.denx.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Rolf Offermanns,

In message <F5B2E7AE-A0C5-4D9B-AF8F-3158B94D6236@sysgo.com> you wrote:
> 
> Thanks Wolfgang, I will try it on monday. What needs to be done to get
> this into mainline?
> 
> Modify the sm501 stuff for fdt and extend the tqm5200.dts file with the
> sm501 resources?

Right, especially the OF bindings in the SM501 driver and the device
tree entries are still missing.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
He'd been wrong, there _was_ a light at the end of the tunnel, and it
was a flamethrower.                         - Terry Pratchett, _Mort_
