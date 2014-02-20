Return-Path: <ruchika.k@servergy.com>
Received: from mail-oa0-f49.google.com (mail-oa0-f49.google.com
 [209.85.219.49])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D26B92C030A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 05:56:20 +1100 (EST)
Received: by mail-oa0-f49.google.com with SMTP id i4so350672oah.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2014 10:56:16 -0800 (PST)
Received: from [10.10.0.165] ([72.34.182.10])
 by mx.google.com with ESMTPSA id g4sm1605304obe.5.2014.02.20.10.56.15
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Thu, 20 Feb 2014 10:56:15 -0800 (PST)
Message-ID: <53064FC9.8070908@servergy.com>
Date: Thu, 20 Feb 2014 12:56:09 -0600
From: Ruchika <ruchika.k@servergy.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Question about EHCI on P4080
References: <530598D7.5080602@servergy.com>
In-Reply-To: <530598D7.5080602@servergy.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

linuxppc,
Is there another mailing list which is more appropriate ?
If so I'd be happy to get a recommendation.

Thank you
Regards
ruchika


On 2/19/2014 11:55 PM, Ruchika wrote:
> Hi,
> I've been trying to understand why the uboot code is unable to work with
> USB1.1 devices.
> On a USB analyzer:
> I notice on an analyzer that there are no SOF or IN tokens seen on the
> bus at all. The only  after the very first setup packet is sent and ACK'd.
>
> The board has a hub chip on it connected to the USB controller via a
> Ulpi interface.
>
> Uboot debug indicates that the transfer times out and was still "Active"
>
> The kernel code indicates that a companion driver handles 1.1 devices.
> Does this mean there are 2 HCD's, one for HS and one for FS/LS in the
> kernel ?
> Thank you
>
>
> ruchika
