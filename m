Return-Path: <r&d2@dave-tech.it>
Received: from mx.dave-tech.it (mx.dave-tech.it [88.37.112.223])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "localhost", Issuer "www.qmailtoaster.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 59D7DDDE1E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Feb 2008 19:43:13 +1100 (EST)
Message-ID: <47B2AC0A.9040107@dave-tech.it>
Date: Wed, 13 Feb 2008 09:36:26 +0100
From: llandre <r&d2@dave-tech.it>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: TEMAC on Virtex FX12: device occupation
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

Hi all,

I'd like to hear some opinions about this post by Massimiliano:

http://article.gmane.org/gmane.linux.ports.ppc.embedded/17568

The results he got are quite impressive. It seems that everybody here 
can hardly fit a design with just one hard TEMAC in FX12 while he was 
able to fit two! Unfortunately Massimiliano did not say precisely how he 
did it. I'd like to hear someone from Xilinx sharing his/her opinion 
about this outstanding result. Maybe he used 3rd-party synthesizer or he 
discovered some magical command-line parameters for Xilinx synthesizer ...
Any comment will be appreciated.


Regards,
llandre

DAVE Electronics System House - R&D Department
web:   http://www.dave.eu
email: r&d2@dave-tech.it
