Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id DA9CA689D7
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jan 2006 12:19:26 +1100 (EST)
To: "Kabir Ahsan-r9aahw" <Ahsan.Kabir@freescale.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: init does not run on 405GP system 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 12 Jan 2006 15:51:57 MST."
	<351763BE49AC8743AFCCF925821FF6BE04A503@az33exm22.fsl.freescale.net>
Date: Fri, 13 Jan 2006 02:19:24 +0100
Sender: wd@denx.de
Message-Id: <20060113011924.1C149353CCD@atlas.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <351763BE49AC8743AFCCF925821FF6BE04A503@az33exm22.fsl.freescale.net> you wrote:
> 
> I found this thread on the web. The reason I am writing is that I am
> also seeing some problem with my /sbin/init. Can you elaborate on the
> solution? You mentioned that "The On Chip Memory was mapped to an
> address below 0x8000'0000 - what we didn't know was that this is a
> _virtual_ address, because the OCM is not simply located "behind" the
> MMU."=20
> What do you mean by OCM? What do you mean by address below 0x80000000?

OCM = On Chip Memory (this should be obvious from the previous text).

And address "below 0x80000000" is  one  in  the  address  range  from
0x0000 up to and including 0x7FFFFFFF (this should be obvious, too).

> So you had to redefine your MMU definition to get through this error?

No, just fix your memory map.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The use of anthropomorphic terminology when  dealing  with  computing
systems is a symptom of professional immaturity.   -- Edsger Dijkstra
