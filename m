Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com
 [209.85.192.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4812E1A060F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2015 18:02:20 +1000 (AEST)
Received: by pdbep18 with SMTP id ep18so101612733pdb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2015 01:02:18 -0700 (PDT)
Subject: Re: [PATCH slof] README: Update with patch submittion note
To: Thomas Huth <thuth@redhat.com>
References: <1436155750-16815-1-git-send-email-aik@ozlabs.ru>
 <20150706092224.414d7e5e@thh440s>
Cc: linuxppc-dev@lists.ozlabs.org,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, slof@lists.ozlabs.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <559A35F8.3080301@ozlabs.ru>
Date: Mon, 6 Jul 2015 18:02:00 +1000
MIME-Version: 1.0
In-Reply-To: <20150706092224.414d7e5e@thh440s>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/06/2015 05:22 PM, Thomas Huth wrote:
> On Mon,  6 Jul 2015 14:09:10 +1000
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>
>> This adds a maillist and emails to be used when posting a patch for SLOF.
>>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Thomas Huth <thuth@redhat.com>
>> Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>
>> I was asked to describe somewhere how to post new patches so this is the first
>> attempt. Please fix my english and add/remove personal emails and any other
>> comments are also welcome. Thanks!
>
> I think you should add least add a sentence that the subject should
> contain "[SLOF PATCH...]", so that people on the list can see at a
> first glance that the patch is about SLOF.

===
Patches for SLOF should be made against https://github.com/aik/SLOF,
the master branch and posted to slof@ozlabs.org.
It is recommended cc: to aik@ozlabs.ru, nikunj@linux.vnet.ibm.com,
thuth@redhat.com.
===

> And IMHO it would be really better to finally have a dedicated mailing
> list for SLOF - even if it's low traffic only. It would help filtering
> your mails and maybe also attract people who do not want to receive the
> whole other traffic from the linux-ppc mailing list.

slof@lists.ozlabs.org it is then, I changed the message above.



-- 
Alexey
