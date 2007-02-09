Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 97CC5DDE25
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Feb 2007 11:46:12 +1100 (EST)
To: "Fillod Stephane" <stephane.fillod@thomson.net>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: multiple devices using ELDK NFS mounts 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 08 Feb 2007 14:04:51 +0100."
	<0B45E93C5FF65740AEAE690BF3848B7A4AAF68@rennsmail04.eu.thmulti.com>
Date: Fri, 09 Feb 2007 01:46:09 +0100
Sender: wd@denx.de
Message-Id: <20070209004610.04F8D353A6C@atlas.denx.de>
Cc: Daniel Ng <daniel_ng11@lycos.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <0B45E93C5FF65740AEAE690BF3848B7A4AAF68@rennsmail04.eu.thmulti.com> you wrote:
>
> ELDK is not an end-product, it's a starter-product ;-)

May I quote this? :-)

> Thank goes to DENX Software Engineering for their nice package.
> BTW, ELDK 4.1 has been released recently, and it includes among
> other things Xenomai and the long awaited uClibc support.

Don't expect too much. Wee added this because customers asked for it.
But I am not a fan of it. You safe some 800 kB or so in the target
root file system - and win a lot of trouble.

> PS: I am in no way associated with DENX, I'm just a happy customer who

Glad to hear that.

The next "long awaited" feature will be ELDK on Windoze. Available in
... say 30 minutes from now? :-)

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Hi there! This is just a note from me, to you, to tell you, the  per-
son  reading this note, that I can't think up any more famous quotes,
jokes, nor bizarre stories, so you may as well go home.
