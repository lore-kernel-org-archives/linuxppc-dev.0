Return-Path: <martyn.welch@ge.com>
Received: from exprod5og103.obsmtp.com (exprod5og103.obsmtp.com [64.18.0.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 164332C008F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2012 19:53:39 +1000 (EST)
Message-ID: <5034AC1E.2030208@ge.com>
Date: Wed, 22 Aug 2012 10:53:34 +0100
From: Martyn Welch <martyn.welch@ge.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: GE IMP3a
References: <68C39493-C518-4898-954B-CA2E1DCF5DAD@kernel.crashing.org>
 <50338169.8040102@ge.com>
 <D8AFDE1A-73A8-4C7C-817C-CBB95CEDA98B@kernel.crashing.org>
In-Reply-To: <D8AFDE1A-73A8-4C7C-817C-CBB95CEDA98B@kernel.crashing.org>
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

On 21/08/12 14:58, Kumar Gala wrote:
> 
> On Aug 21, 2012, at 7:39 AM, Martyn Welch wrote:
> 
>> On 15/08/12 22:32, Kumar Gala wrote:
>>> Do you know why ge_imp3a.c has 0x9000 as the 'primary' PCIe bus on the board?
>>>
>>
>> Hi Kumar,
>>
>> Sorry, missed your mail.
> 
> np.
> 
>> At a quick guess it's because that's the interface that is used for the
>> on-board PCI devices.
> 
> What PCI devices are on-board?
> 

Just SATA.

> Does the board have any PCIe-ISA bridges?
> 

No, though SERDES Port 1 is connected to a PCie-PCI non-transparent bridge to
a PCI backplane.

> [ if you can generate an lspci dump, that might answer some of these questions ]
> 

Sorry, I don't have easy access to a board at the moment.

Martyn

-- 
Martyn Welch (Lead Software Engineer)  | Registered in England and Wales
GE Intelligent Platforms               | (3828642) at 100 Barbirolli Square
T +44(0)1327322748                     | Manchester, M2 3AB
E martyn.welch@ge.com                  | VAT:GB 927559189
