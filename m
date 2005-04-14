Return-Path: <Schramel.Linux@go.bartec.de>
Received: from mail.bartec.de (mail.bartec.de [217.5.168.170])
	by ozlabs.org (Postfix) with SMTP id 454F267B70
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Apr 2005 22:24:34 +1000 (EST)
From: Marco Schramel <Schramel.Linux@go.bartec.de>
To: Dan Malek <dan@embeddededge.com>,
	"PPC_LINUX" <linuxppc-embedded@ozlabs.org>
Date: Thu, 14 Apr 2005 14:54:03 +0200
References: <200504140926.01775.Schramel.Linux@go.bartec.de>
	<a06218f5ec69af94cf7d5f7616eed028@embeddededge.com>
In-Reply-To: <a06218f5ec69af94cf7d5f7616eed028@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200504141454.03704.Schramel.Linux@go.bartec.de>
Subject: Re: CPM uart
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Dan,

thanks for your answer.

> > During booting kernel hangs on initializing ttyS2 forever.
> 
> That is the console port, so take a look at the code for its
> initialization for something affected by this configuration.
> What kernel are you using?  There have been lots of
> updates in recent versions.

I use kernel version 2.4.25 of denx and the uart version is 
static char *serial_name = "CPM UART driver";
static char *serial_version = "0.01";

Are there newer versions? Sorry, but i am not up to date with the uart.
Is my configuration so extraordinary ;-) ?

Thanks
Marco



-- 
---------
Marco Schramel
