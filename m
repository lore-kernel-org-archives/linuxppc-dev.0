Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3579D681E9
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Sep 2005 18:32:51 +1000 (EST)
Date: Thu, 8 Sep 2005 09:32:31 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: =?ISO-8859-1?B??= <rober@opnet.com.tw>
Message-Id: <20050908093231.4b19bdf8.ajz@cambridgebroadband.com>
In-Reply-To: <1126163212.23563.8.camel@banana>
References: <1126163212.23563.8.camel@banana>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Can't run 8M ramdisk at 2.4.20 linux
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

EMAIL <rober@opnet.com.tw> wrote:

> Hi All:
> 
>     I build a 8M ramdisk file, it  works fine at 2.4.25 linux but fail
> in 2.4.20.Why?
> I do follow command to make 8M ramdsik, all files in the ramdisk is from
> pRamdisk (download from denx ftp site).


Possibly a kernel config error.  Look for CONFIG_BLK_DEV_RAM_SIZE in your .config.  You need

CONFIG_BLK_DEV_RAM_SIZE=8192

Alex
