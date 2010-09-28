Return-Path: <micha@neli.hopto.org>
Received: from edu-smtp-01.edutel.nl (edu-smtp-01.edutel.nl [88.159.1.175])
	by ozlabs.org (Postfix) with ESMTP id 390A1B6EEE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Sep 2010 23:46:50 +1000 (EST)
Message-ID: <4CA1F1C3.1020704@neli.hopto.org>
Date: Tue, 28 Sep 2010 15:46:43 +0200
From: Micha Nelissen <micha@neli.hopto.org>
MIME-Version: 1.0
To: Carlos Roberto Moratelli <carlos.moratelli@digitel.com.br>
Subject: Re: Doubt about Linux PCIe infraestructure
References: <1285672565.6920.3.camel@parana.digitel.com.br>
In-Reply-To: <1285672565.6920.3.camel@parana.digitel.com.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Carlos Roberto Moratelli wrote:
> When I register a PCI driver using pci_register_driver() will the 
> probe function be automatically called or will it just be called if PCI 
> infraestructure match a Vendor and Device id on bus?

Yes, vendor and device id must match. You can find those in lspci.

Micha
