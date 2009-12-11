Return-Path: <jacmet@gmail.com>
Received: from mail-ew0-f209.google.com (mail-ew0-f209.google.com
	[209.85.219.209]) by ozlabs.org (Postfix) with ESMTP id 7A3A6B6F0D
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Dec 2009 02:31:35 +1100 (EST)
Received: by ewy1 with SMTP id 1so1086076ewy.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Dec 2009 07:31:31 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/3] mpc8xxx_gpio: add interrupt support
References: <1259700494-17869-1-git-send-email-jacmet@sunsite.dk>
	<1259700494-17869-2-git-send-email-jacmet@sunsite.dk>
	<1259700494-17869-3-git-send-email-jacmet@sunsite.dk>
	<87pr6omwk3.fsf@macbook.be.48ers.dk>
	<8F2E2097-9BB7-4B7F-902E-F967F28120E8@kernel.crashing.org>
Date: Fri, 11 Dec 2009 16:31:22 +0100
In-Reply-To: <8F2E2097-9BB7-4B7F-902E-F967F28120E8@kernel.crashing.org> (Kumar
	Gala's message of "Thu, 10 Dec 2009 20:13:35 -0600")
Message-ID: <87r5r1ttmd.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>>> "Kumar" == Kumar Gala <galak@kernel.crashing.org> writes:

Hi,

 Kumar> We need a binding document to go with this.

Ok, but where should it go? In the existing
powerpc/dts-bindings/fsl/8xxx_gpio.txt or somewhere seperate? I don't
see any other interrupt controller documentation besides the stuff in
booting-without-of.txt

-- 
Bye, Peter Korsgaard
