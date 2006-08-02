Return-Path: <frannk_m1@yahoo.com>
Received: from web32202.mail.mud.yahoo.com (web32202.mail.mud.yahoo.com
	[68.142.207.133]) by ozlabs.org (Postfix) with SMTP id 8F9C267B94
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2006 02:41:29 +1000 (EST)
Message-ID: <20060802164127.73497.qmail@web32202.mail.mud.yahoo.com>
Date: Wed, 2 Aug 2006 09:41:27 -0700 (PDT)
From: Frank <frannk_m1@yahoo.com>
Subject: Re: Sloooooowwww CFI Flash programming
To: "Franca, Jose Filipe \(ext\)" <jose.franca.ext@siemens.com>,
	linuxppc-dev@ozlabs.org
In-Reply-To: <4051B1A83682514BA8529BCADDA45F086EE61D@PTLISI050MSX.PT001.SIEMENS.NET>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



--- "Franca, Jose Filipe (ext)" <jose.franca.ext@siemens.com>
wrote:

> Hello all!
> 
> 	I'm using a linux-2.4.31 based kernel in our board and we are
> using a AM29LV040B flash device. Our problem is that flash
> programming is a rather slow process. The responsible is the
> file cfi_cmdset_0002.c. Is there any patch that fixes this
> problem and enables fast programming mode?
> 
>

You probably need buffer writes enabled.

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
