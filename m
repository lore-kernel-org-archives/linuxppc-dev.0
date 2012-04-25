Return-Path: <jwboyer@gmail.com>
Received: from mail-qa0-f51.google.com (mail-qa0-f51.google.com
 [209.85.216.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E8E81B6FBD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2012 23:07:21 +1000 (EST)
Received: by qaea16 with SMTP id a16so853532qae.17
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2012 06:07:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F97C243.80806@in.ibm.com>
References: <20120416082449.27331.12488.stgit@suzukikp.in.ibm.com>
 <4F97C243.80806@in.ibm.com>
Date: Wed, 25 Apr 2012 09:07:17 -0400
Message-ID: <CA+5PVA7wS7nWMZwVMjVRMuL81dpjGz1r82SekTyYX3NioKivMg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Kdump support for 47x
From: Josh Boyer <jwboyer@gmail.com>
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 25, 2012 at 5:22 AM, Suzuki K. Poulose <suzuki@in.ibm.com> wrot=
e:
> On 04/16/2012 01:56 PM, Suzuki K. Poulose wrote:
>>
>> The following series implements Kexec/Kdump support for
>> PPC_47x based platforms. Doesn't support SMP yet.
>>
>> I have tested these patches on the following simulators:
>> =A0 =A0 =A0 =A0 1) simics
>> =A0 =A0 =A0 =A0 2) IBM ISS for ppc476.
>>
>> Changes since V1:
>> =A0* Initialize the SPRN_PID to kernel pid (0) before the TLB operations=
 in
>> =A0 =A0setup_map_47x
>>
>>
>
> Josh,
>
> Did you get a chance to look at this ?

Not yet.  I'll try to get to this and some other patches APM submitted
before the end of the week.  Apologies for the delay.

josh
