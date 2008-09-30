Return-Path: <gvb.linuxppc.dev@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.172])
	by ozlabs.org (Postfix) with ESMTP id 2F44CDDF91
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Oct 2008 08:30:13 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so272885wfg.15
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 15:30:11 -0700 (PDT)
Message-ID: <eee4c0020809301530w20d6d1e4sd2e3542366cc595d@mail.gmail.com>
Date: Tue, 30 Sep 2008 18:30:11 -0400
From: "Gerald Van Baren" <gvb.linuxppc.dev@gmail.com>
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: Device Tree
In-Reply-To: <48E2444D.1050301@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <48E07490.9020805@enseirb.fr> <48E09108.4020400@ru.mvista.com>
	<48E2444D.1050301@genesi-usa.com>
Cc: =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?= <chretien@enseirb.fr>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matt Sealey wrote:
>
> Sergei Shtylyov wrote:
>> Hello.
>>
>> S=E9bastien Chr=E9tien wrote:
>>> Hello,
>>> I have a question about Device Tree.
>>> Is Device Tree found only only on Linux Powerpc ?
>>
>>   Not only Linux as it's a part of Open Firmware which is also used at
>> least on SPARC.
>
> The Toshiba TOPAS910 ARM development board also runs Open Firmware and
> contains patches to support OF device trees.
>
> I dare say there might be an x86 box or two out there, too. But they
> have ACPI tables too which is far more common..

More than a box or two: lots of OLPC XOs out there now.  ;-)
    <http://wiki.laptop.org/go/Open_Firmware>

Best regards,
gvb
