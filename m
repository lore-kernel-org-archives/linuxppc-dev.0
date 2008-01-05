Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 70765DDE03
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Jan 2008 06:19:24 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] i2c-ibm_iic driver
Date: Sat, 5 Jan 2008 20:18:22 +0100
References: <477EF225.4070505@pikatech.com> <200801051354.11202.arnd@arndb.de>
	<477FCE21.9080808@pikatech.com>
In-Reply-To: <477FCE21.9080808@pikatech.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200801052018.22954.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 05 January 2008, Sean MacLennan wrote:
> 
> Ok. The 44x based .dts files do not list 405-iic, so would I think I 
> will add two compatibility matches, one for 405 and one for 440EP. That 
> way I do not break all the current .dts files. Everybody ok with that?
> 

Sounds good. There are obviously no other drivers that know only
about 405 but not about 440, so there is no backwards compatibility
problem. If we ever get a 450/460/470/... that we want to support
with this driver, it can simply claim to be compatible with 440 or 405
if not both.

	Arnd <><
