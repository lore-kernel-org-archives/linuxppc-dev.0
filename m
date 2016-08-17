Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sDXcD1wRkzDqdr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 12:05:00 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id y134so6470688pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Aug 2016 19:05:00 -0700 (PDT)
Subject: Re: [PATCH v5 02/13] kexec_file: Change kexec_add_buffer to take
 kexec_buf as argument.
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
References: <1470956898-5991-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1906561.y8blzB2uZ8@hactar> <fab1a3ec-5252-3ca7-6382-15b84a19ccdb@gmail.com>
 <2089791.XEmIvA1k4K@hactar>
Cc: kexec@lists.infradead.org, Stewart Smith <stewart@linux.vnet.ibm.com>,
 Baoquan He <bhe@redhat.com>, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Eric Biederman <ebiederm@xmission.com>, Thomas Gleixner
 <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <edca3e4a-1901-eab4-6626-390c835b00c7@gmail.com>
Date: Wed, 17 Aug 2016 12:04:49 +1000
MIME-Version: 1.0
In-Reply-To: <2089791.XEmIvA1k4K@hactar>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 17/08/16 04:49, Thiago Jung Bauermann wrote:
> Am Dienstag, 16 August 2016, 16:15:55 schrieb Balbir Singh:
>> On 16/08/16 00:49, Thiago Jung Bauermann wrote:
>>> Am Montag, 15 August 2016, 17:30:49 schrieb Balbir Singh:
>>>> On Thu, Aug 11, 2016 at 08:08:07PM -0300, Thiago Jung Bauermann wrote:
>>>>> Adapt all callers to the new function prototype.
>>>>
>>>> Could you please expand on this?
>>>
>>> Is the following better?
>>>
>>> Adapt all callers to set up a kexec_buf to pass to kexec_add_buffer.
>>
>> Yes and the reason for doing so? Consolidation/clarity of implementation?
> 
> Indeed. What about this commit message?
> 
> Subject: [PATCH v5 02/13] kexec_file: Change kexec_add_buffer to take  
>  kexec_buf as argument.
> 
> This is done to simplify the kexec_add_buffer argument list.
> Adapt all callers to set up a kexec_buf to pass to kexec_add_buffer.
> 
> In addition, change the type of kexec_buf.buffer from char * to void *.
> There is no particular reason for it to be a char *, and the change
> allows us to get rid of 3 existing casts to char * in the code.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> Acked-by: Dave Young <dyoung@redhat.com>
> Acked-by: Balbir Singh <bsingharora@gmail.com>
> 


Looks good

Balbir
