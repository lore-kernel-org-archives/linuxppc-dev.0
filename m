Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D6E1C1A115D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 20:13:19 +1100 (AEDT)
Received: by padet14 with SMTP id et14so9802550pad.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 02:13:18 -0700 (PDT)
Message-ID: <55000727.4010203@ozlabs.ru>
Date: Wed, 11 Mar 2015 20:13:11 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Thomas Huth <thuth@linux.vnet.ibm.com>
Subject: Re: [PATCH SLOF] pci-properties: Remove redundant call to device-type
References: <1426055192-28691-1-git-send-email-aik@ozlabs.ru>	
 <20150311085030.43ac4fac@oc7435384737.ibm.com>
 <1426062062.17565.22.camel@kernel.crashing.org>
In-Reply-To: <1426062062.17565.22.camel@kernel.crashing.org>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/11/2015 07:21 PM, Benjamin Herrenschmidt wrote:
> On Wed, 2015-03-11 at 08:50 +0100, Thomas Huth wrote:
>>
>> - Graphic cards should get the "display" device_type ... I guess
>> that's
>>    missing now?
>
> At least the code for qemu-vga does it
>
>> - pci bus nodes (like bridges) should get the "pci" device_type
>>    according to the Open Firmware PCI binding, is this still the case?
>
> Ah yes we need to check that, specifically P2P bridges
>
>> - Seems like there are some other devices with device_type property
>>    where SLOF does not provide an implemented interface, like in
>>    slof/fs/usb/dev-mouse.fs ... should these be revised, too?
>
> not a *huge* issue but we can look into it when needed.


Then I better remove it now as well, any reason to wait for "when needed"?



-- 
Alexey
