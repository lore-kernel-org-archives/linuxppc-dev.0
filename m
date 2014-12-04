Return-Path: <pefoley2@pefoley.com>
Received: from mail-la0-x22c.google.com (mail-la0-x22c.google.com
 [IPv6:2a00:1450:4010:c03::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 230321A0297
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 04:01:52 +1100 (AEDT)
Received: by mail-la0-f44.google.com with SMTP id ge10so14704230lab.31
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Dec 2014 09:01:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1417712272.88385.4.camel@localhost>
References: <54806490.6080303@redhat.com>
 <45C67EF7794AF747A87A45C9E1CC1B97926A6AFD@ORSMSX105.amr.corp.intel.com>
 <1417712272.88385.4.camel@localhost>
From: Peter Foley <pefoley2@pefoley.com>
Date: Thu, 4 Dec 2014 12:01:25 -0500
Message-ID: <CAOFdcFOZHAEGycaSRKKahZrTssAL0StNKFXqtVmEYp3hcWm1kg@mail.gmail.com>
Subject: Re: ppc64 and Documentation/mic/mpssd/mpssd.c issues
To: Sudeep Dutt <sudeep.dutt@intel.com>
Content-Type: text/plain; charset=UTF-8
Cc: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>,
 Daniel Borkmann <dborkman@redhat.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Yokoyama,
 Caz" <caz.yokoyama@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 4, 2014 at 11:57 AM, Sudeep Dutt <sudeep.dutt@intel.com> wrote:
> On Thu, 2014-12-04 at 08:48 -0800, Yokoyama, Caz wrote:
>> Thank you for the report.
>> Have you tried to compile on x86_64? Which rhel do you use? Rhel6.X?
>> MIC card is expected to work with x86_64 host, not with ppc64. We have never compiled on ppc host while our primary development platform was rhel6.X.
>>
>
> I am adding Peter Foley since he enabled the mpssd build by default
> recently with commit adb19fb. Peter, is there a way to enable the mpssd
> build only for x86_64?

Change hostprogs-y to hostprogs-$(CONFIG_X86_64) in the mpssd Makefile.
That will restrict it to x86_64 only.
