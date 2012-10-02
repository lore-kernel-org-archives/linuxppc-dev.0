Return-Path: <kosaki.motohiro@gmail.com>
Received: from mail-oa0-f51.google.com (mail-oa0-f51.google.com
 [209.85.219.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 903892C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2012 03:28:48 +1000 (EST)
Received: by oagn12 with SMTP id n12so6729723oag.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Oct 2012 10:28:44 -0700 (PDT)
MIME-Version: 1.0
Sender: kosaki.motohiro@gmail.com
In-Reply-To: <506A36A1.6030709@gmail.com>
References: <1346837155-534-1-git-send-email-wency@cn.fujitsu.com>
 <1346837155-534-7-git-send-email-wency@cn.fujitsu.com>
 <506A36A1.6030709@gmail.com>
From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Date: Tue, 2 Oct 2012 13:28:24 -0400
Message-ID: <CAHGf_=rX-OHFkBCKzdOi-ydF3VY+Sv_J1osDzZ_MiYEoop145A@mail.gmail.com>
Subject: Re: [RFC v9 PATCH 06/21] memory-hotplug: export the function
 acpi_bus_remove()
To: Ni zhan Chen <nizhan.chen@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
 wency@cn.fujitsu.com, linux-acpi@vger.kernel.org, linux-sh@vger.kernel.org,
 len.brown@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 cmetcalf@tilera.com, linux-mm@kvack.org, isimatu.yasuaki@jp.fujitsu.com,
 paulus@samba.org, minchan.kim@gmail.com, rientjes@google.com,
 sparclinux@vger.kernel.org, cl@linux.com, linuxppc-dev@lists.ozlabs.org,
 akpm@linux-foundation.org, liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 1, 2012 at 8:34 PM, Ni zhan Chen <nizhan.chen@gmail.com> wrote:
> On 09/05/2012 05:25 PM, wency@cn.fujitsu.com wrote:
>>
>> From: Wen Congyang <wency@cn.fujitsu.com>
>>
>> The function acpi_bus_remove() can remove a acpi device from acpi device.
>
> IIUC, s/acpi device/acpi bus

IIUC, acpi_bus_remove() mean "remove the device from a bus".
