Return-Path: <martyn.welch@ge.com>
Received: from exprod5og111.obsmtp.com (exprod5og111.obsmtp.com [64.18.0.22])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6652F2C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2012 22:44:18 +1000 (EST)
Message-ID: <50338169.8040102@ge.com>
Date: Tue, 21 Aug 2012 13:39:05 +0100
From: Martyn Welch <martyn.welch@ge.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: GE IMP3a
References: <68C39493-C518-4898-954B-CA2E1DCF5DAD@kernel.crashing.org>
In-Reply-To: <68C39493-C518-4898-954B-CA2E1DCF5DAD@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 15/08/12 22:32, Kumar Gala wrote:
> Do you know why ge_imp3a.c has 0x9000 as the 'primary' PCIe bus on the board?
> 

Hi Kumar,

Sorry, missed your mail.

At a quick guess it's because that's the interface that is used for the
on-board PCI devices.

Martyn


-- 
Martyn Welch (Lead Software Engineer)  | Registered in England and Wales
GE Intelligent Platforms               | (3828642) at 100 Barbirolli Square
T +44(0)1327322748                     | Manchester, M2 3AB
E martyn.welch@ge.com                  | VAT:GB 927559189
