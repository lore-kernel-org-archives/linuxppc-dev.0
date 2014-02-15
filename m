Return-Path: <linux@roeck-us.net>
Received: from mail.active-venture.com (mail.active-venture.com
 [67.228.131.205]) by ozlabs.org (Postfix) with ESMTP id CC64B2C009F
 for <linuxppc-dev@ozlabs.org>; Sun, 16 Feb 2014 05:09:13 +1100 (EST)
Message-ID: <52FFABB7.3090302@roeck-us.net>
Date: Sat, 15 Feb 2014 10:02:31 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix "attempt to move .org backwards" error
References: <20131209191015.22974.31604.stgit@mars>
 <20131210101031.82b02468d32ddb89481b24b9@canb.auug.org.au>
 <1386631570.32037.40.camel@pasglop>
 <20140212162251.57472ed024ace170b49ec2fa@canb.auug.org.au>
In-Reply-To: <20140212162251.57472ed024ace170b49ec2fa@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linux-next <linux-next@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/11/2014 09:22 PM, Stephen Rothwell wrote:
> Hi all,
>
> On Tue, 10 Dec 2013 10:26:10 +1100 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>>
>> On Tue, 2013-12-10 at 10:10 +1100, Stephen Rothwell wrote:
>>> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
>>> Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>
>>>
>>> Works for me.  Thanks.  I will add this to linux-next today if Ben
>>> doesn't add it to his tree.
>>
>> I will but probably not soon enough for your cut today
>
> As noted elsewhere, this did not completely fix the problem and I have
> been still getting this error from my allyesconfig builds for some time:
>

+allmodconfig in latest mainline.

> arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
> arch/powerpc/kernel/exceptions-64s.S:1312: Error: attempt to move .org backwards
>
> Could someone please fix this?
>

Guenter
