Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wnZ5F6MlZzDqKy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 14:53:05 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>,
 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: "open list\:LINUX FOR POWERPC \(32-BIT AND 64-BIT\)"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] recordmcount.pl: Add ppc64le to list of supported
 architectures
In-Reply-To: <CAKTCnz=xeDFbyPwsdewq-5NK9cgQpBVCfCX_iL5f8u2-y7HwDw@mail.gmail.com>
References: <1497336599-17894-1-git-send-email-kamalesh@linux.vnet.ibm.com>
 <CAKTCnz=xeDFbyPwsdewq-5NK9cgQpBVCfCX_iL5f8u2-y7HwDw@mail.gmail.com>
Date: Wed, 14 Jun 2017 14:53:05 +1000
Message-ID: <87a85b41ce.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:
> On Tue, Jun 13, 2017 at 4:49 PM, Kamalesh Babulal <
> kamalesh@linux.vnet.ibm.com> wrote:
>> diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
>> index 1633c3e..683b8b5 100755
>> --- a/scripts/recordmcount.pl
>> +++ b/scripts/recordmcount.pl
>> @@ -264,7 +264,7 @@ if ($arch eq "x86_64") {
>>      $ld .= " -m shlelf_linux";
>>      $objcopy .= " -O elf32-sh-linux";
>>
>> -} elsif ($arch eq "powerpc") {
>> +} elsif ($arch eq "powerpc" || $arch eq "ppc64le") {
>>
>
> I don't get this, the arch should always be powerpc.

Right. Something else is fubar for that to happen, we should fix
whatever it is.

cheers
