Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id C303667B83
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Nov 2006 22:33:39 +1100 (EST)
Message-ID: <45682A1E.7020604@ru.mvista.com>
Date: Sat, 25 Nov 2006 14:33:50 +0300
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Andy Gotz <andy.gotz@esrf.fr>
Subject: Re: Memec v4fx12lc - problem booting linux on ppc
References: <1164022946.8340.6.camel@l-cb312-1.esrf.fr>
	<JG200611211159003.3859000@co-nss.co.jp>
	<1164102298.21858.4.camel@l-cb312-1.esrf.fr>
	<4562E546.9070401@ru.mvista.com>
	<7.0.1.0.1.20061121153812.0430db90@esrf.fr>
	<45632A8E.3010509@ru.mvista.com>
	<7.0.1.0.1.20061124164552.01f06298@esrf.fr>
	<45675884.80108@esrf.fr>
In-Reply-To: <45675884.80108@esrf.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Olivier GOUDARD <olivier.goudard@esrf.fr>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Andy,

Andy Gotz wrote:
<snip>
> xilinx_char_lcd at 0xFE804800 (256 bytes) mapped to 0xC50C2800
> Data machine check in kernel mode.
> Oops: machine check, sig: 7
...

Looks like the kernel tries accessing non-existing IP, or the IP
triggers some error on the bus.
Could you tell me what IP the xilinx_char_lcd driver is expected
to work with in your design?

Thanks,
Andrei
