Return-Path: <jwboyer@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 11CE8B71A2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 21 May 2011 10:38:22 +1000 (EST)
Received: by vxi40 with SMTP id 40so3472397vxi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 17:38:18 -0700 (PDT)
MIME-Version: 1.0
Sender: jwboyer@gmail.com
In-Reply-To: <20110520215835.GA14918@kroah.com>
References: <20110520202225.GI25179@zod.rchland.ibm.com>
	<20110520215835.GA14918@kroah.com>
Date: Fri, 20 May 2011 20:38:18 -0400
Message-ID: <BANLkTi=upg115LcMRBdNpcGJXZZBc2bz2A@mail.gmail.com>
Subject: Re: [stable] [PATCH] powerpc: Fix 32-bit SMP build
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 20, 2011 at 5:58 PM, Greg KH <greg@kroah.com> wrote:
> On Fri, May 20, 2011 at 04:22:25PM -0400, Josh Boyer wrote:
>> Commit 69e3cea8d5fd526 introduced start_secondary_resume to misc_32.S,
>> however it uses a 64-bit instruction which is not valid on 32-bit
>> platforms. =A0Use 'stw' instead.
>>
>> Reported-by: Richard Cochran <richardcochran@gmail.com>
>> Tested-by: Richard Cochran <richardcochran@gmail.com>
>> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
>>
>> ---
>
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree. =A0Please read Documentation/stable_kernel_rules.txt
> for how to do this properly.
>
> </formletter>

Sigh.  I know that.  My fault for rushing it and not thinking.

josh
