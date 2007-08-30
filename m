Return-Path: <orutsch@sympatec.com>
Received: from sympatec.com (mail.sympatec.net [217.5.250.35])
	(using SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D267DDDE23
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Aug 2007 19:20:42 +1000 (EST)
Received: from [172.20.3.151] (account rutsch [172.20.3.151] verified)
	by sympatec.com (CommuniGate Pro SMTP 5.1.4)
	with ESMTPSA id 1986906 for linuxppc-embedded@ozlabs.org;
	Thu, 30 Aug 2007 11:20:55 +0200
Message-ID: <46D68BA6.4020102@sympatec.com>
Date: Thu, 30 Aug 2007 11:19:34 +0200
From: Oliver Rutsch <orutsch@sympatec.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: STK5200 pci_enable_device problem
References: <20070829233106.9766C24044@gemini.denx.de>
In-Reply-To: <20070829233106.9766C24044@gemini.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi again,

> 
> As mentioned above, with arch/powerpc you always need a  device  tree
> blob.
> 
> Best regards,
> 
> Wolfgang Denk
> 

Thanks, Wolfang, now it's booting fine!
I've updated u-boot to the newest git version, builded the device tree 
file and now everything's working.

Bye,

-- 
Dipl. Ing. Oliver Rutsch
