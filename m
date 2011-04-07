Return-Path: <martyn.welch@ge.com>
Received: from exprod5og117.obsmtp.com (exprod5og117.obsmtp.com [64.18.0.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9B6E3B6F71
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Apr 2011 18:32:47 +1000 (EST)
Message-ID: <4D9D7575.1030200@ge.com>
Date: Thu, 07 Apr 2011 09:27:33 +0100
From: Martyn Welch <martyn.welch@ge.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: known working sata_sil24.c setup on powerpc platforms?
References: <BANLkTimXgi26RHHxyBLoN8YqaDy_PL-hGQ@mail.gmail.com>
In-Reply-To: <BANLkTimXgi26RHHxyBLoN8YqaDy_PL-hGQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/04/11 18:00, Leon Woestenberg wrote:
> Hello,
> 
> after investigating problems with sata_sil24.c on a freescale p2020
> soc, I wonder if this driver works on powerpc at all?
> 
> Does anyone know of a working setup of sata_sil24 on a big endian
> powerpc system?
> 

Yes, I think we even use it on a p2020 board, though I think our current
kernel on that product is 2.6.34.

Martyn

-- 
Martyn Welch (Principal Software Engineer) | Registered in England and
GE Intelligent Platforms                   | Wales (3828642) at 100
T +44(0)127322748                          | Barbirolli Square, Manchester,
E martyn.welch@ge.com                      | M2 3AB  VAT:GB 927559189
