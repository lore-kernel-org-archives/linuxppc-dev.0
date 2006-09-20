Return-Path: <Clive.Jenkins@xerox.com>
Received: from wvmler3.mail.xerox.com (wvmler3.mail.xerox.com [13.8.138.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wvmler3.mail.xerox.com",
	Issuer "wvmler3.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8B2C767B73
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Sep 2006 03:08:10 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Couldn't find reference for i2c_smbus functinos
Date: Wed, 20 Sep 2006 17:27:17 +0100
Message-ID: <35786B99AB3FDC45A821572461791973D76E67@gbrwgceumf01.eu.xerox.net>
In-Reply-To: <8584FDC94AFF7640B17B8A89B23B19B34F6576@sbsserver.AlphionCorp.local>
From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
To: "Sachin Rane" <SRane@alphion.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> You can do SMBus level transactions (see documentation file
smbus-protocol
> for details) through the following functions:
>   __s32 i2c_smbus_write_quick(int file, __u8 value);
> ...
> Am I missing any information about the location of the above
functions?

Try reading
http://www.lm-sensors.org/browser/i2c/trunk/doc/dev-interface
and other material on the lm-sensors site

> Do I need to implement the above functions?

No.
