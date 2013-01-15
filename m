Return-Path: <martyn.welch@ge.com>
Received: from exprod5og115.obsmtp.com (exprod5og115.obsmtp.com [64.18.0.246])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6423E2C0086
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2013 20:37:23 +1100 (EST)
Message-ID: <50F5221C.1080308@ge.com>
Date: Tue, 15 Jan 2013 09:32:12 +0000
From: Martyn Welch <martyn.welch@ge.com>
MIME-Version: 1.0
To: ternaryd <ternaryd@gmail.com>
Subject: Re: device tree entry for tsi148
References: <20130115091119.41e2a0f9@vesta>
In-Reply-To: <20130115091119.41e2a0f9@vesta>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 15/01/13 08:11, ternaryd wrote:
> Hi,
> 
> I'm trying to install linux on an e500v2 board with the tsi148
> VME-Bridge, but got stuck. Now it seems that I need to include
> information regarding this bridge into the .dts-file, but can't figure
> out how. Maybe somebody on this list could post the tsi148-specific
> part of a device tree, which I could use as a guide line?
> 

You don't need to include anything about the device it's self, but there will
need to be an entry in the DTS for PCI. Which SOC are you using?

Can you provide your boot log?

Martyn


-- 
Martyn Welch (Lead Software Engineer)  | Registered in England and Wales
GE Intelligent Platforms               | (3828642) at 100 Barbirolli Square
T +44(0)1327322748                     | Manchester, M2 3AB
E martyn.welch@ge.com                  | VAT:GB 927559189
