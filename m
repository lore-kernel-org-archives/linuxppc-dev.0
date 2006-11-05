Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id A581267C92
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  5 Nov 2006 12:33:01 +1100 (EST)
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 4C37E986D2
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  5 Nov 2006 02:32:59 +0100 (CET)
Received: from mail.denx.de (p54967501.dip.t-dialin.net [84.150.117.1])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 371C6925F7
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  5 Nov 2006 02:32:59 +0100 (CET)
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by mail.denx.de (Postfix) with ESMTP id B93CC6D00B2
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  5 Nov 2006 02:32:58 +0100 (CET)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 9B7DC352638
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  5 Nov 2006 02:32:58 +0100 (MET)
To: linuxppc-embedded@ozlabs.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Has anyone 2.6 kernel with Xenomai and MPC5200 Lite running? 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 04 Nov 2006 17:31:19 +0100."
	<20061104163119.GC69112@server.idefix.loc>
Date: Sun, 05 Nov 2006 02:32:58 +0100
Sender: wd@denx.de
Message-Id: <20061105013258.9B7DC352638@atlas.denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20061104163119.GC69112@server.idefix.loc> you wrote:
> 
> I have here a MPC5200 Lite (IceCube/Freescale Lite 5200) and tried to
> get Xenomai running.
> 
> If I use the 2.6 kernel from denx the board boots fine but I am not

Note that we explicitely do NOT support the MPC5200 in this tree yet.

> able to patch the kernel with the adeos patch (adeos-patch is for
> kernel 2.6.18) and the kernel from denx is 2.6.19rc4. I checked the
> changes and they are to much for me to adapt it.

Then just check out the 2.6.18 version of the tree.  This  is  a  git
repo, so seeking to any version you like is a matter of seconds.

> What I need now is a patch for kernel 2.6.18 to get all the MPC5200
> stuff running (priority has the networkchip) or a adeos patch for the
> denx kernel 2.6.19-rc4.

You do not want this, if you're on a MPC5200. I repeat, this  is  not
supported.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
If I had to live my life again,  I'd  make  the  same  mistakes, only
sooner.                                          -- Tallulah Bankhead
