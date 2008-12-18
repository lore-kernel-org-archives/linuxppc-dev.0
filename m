Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 5E138474C1
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 07:04:08 +1100 (EST)
To: Felix Radensky <felix@embedded-sol.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Long boot delay on 460EX with 2.6.28-rc8
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <21070179.post@talk.nabble.com>
References: <21070179.post@talk.nabble.com>
Date: Thu, 18 Dec 2008 21:04:05 +0100
Message-Id: <20081218200405.441278387CC7@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Felix Radensky,

In message <21070179.post@talk.nabble.com> you wrote:
> 
> I'm experiencing a long (around 20 sec) delay from the moment
> u-boot-1.3.4 passes control to linux and until the first kernel message
> appears on console. This happens on custom board, I don't have access
> to Canyonlands to test how it behaves. I did not modify anything in kernel 
> code to make it boot on custom board, just removed PCIX and PCIE0 nodes
> from DTS.

Try using a recent version of U-Boot as a first step (v2009.01-rc1).

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Der Horizont vieler Menschen ist ein Kreis mit Radius Null --
und das nennen sie ihren Standpunkt.
