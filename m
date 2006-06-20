Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 3603D67B18
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Jun 2006 05:27:58 +1000 (EST)
To: =?iso-8859-1?B?Qmr2cm4g1nN0Ynk=?= <Bjorn.Ostby@combitech.se>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Lite5200 NFS mount issue 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 20 Jun 2006 10:15:28 +0200."
	<BF8F9BE6CD17EB4B8C887AB03E6A9B0303F03C@CORPAPPL020.corp.saab.se>
Date: Tue, 20 Jun 2006 21:27:53 +0200
Sender: wd@denx.de
Message-Id: <20060620192753.E1F6B353CA0@atlas.denx.de>
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

In message <BF8F9BE6CD17EB4B8C887AB03E6A9B0303F03C@CORPAPPL020.corp.saab.se> you wrote:
>
> I'm using u-boot 1.1.4 (CVS downloaded 2006-05-04) and ELDK 4.0. I've encountered 
> problems when trying to mount a NFS root filesystem when using the Lite MPC5200

Which version of the Linux kernel is this? Make sure to  use  top  of
tree in the git repository.

Alternatively, use ELDK 3.1 1 which is better suited for a 2.4 kernel
tree.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
core error - bus dumped
