Return-Path: <timur.tabi@gmail.com>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9C510B70E4
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2011 02:57:04 +1100 (EST)
Received: by fxm1 with SMTP id 1so865131fxm.15
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Mar 2011 08:57:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <D9BF0938-44B1-4BB8-BF3C-0A9CB44B9CC5@kernel.crashing.org>
References: <1292830654-7056-1-git-send-email-B33228@freescale.com>
	<20101220145954.GA1126@trinity.fluff.org>
	<D9BF0938-44B1-4BB8-BF3C-0A9CB44B9CC5@kernel.crashing.org>
From: Timur Tabi <timur.tabi@gmail.com>
Date: Tue, 15 Mar 2011 10:56:07 -0500
Message-ID: <AANLkTim0_ttjDPJvx71B-=Ze5dRTrKXfpavx7gxvYr5p@mail.gmail.com>
Subject: Re: [PATCH] I2C: Add support for 64bit system.
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Xulei <B33228@freescale.com>, linux-i2c@vger.kernel.org,
	Ben Dooks <ben-i2c@fluff.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 15, 2011 at 10:44 AM, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Dec 20, 2010, at 8:59 AM, Ben Dooks wrote:
>
>> On Mon, Dec 20, 2010 at 03:37:34PM +0800, Xulei wrote:
>>> Currently I2C_MPC supports 32bit system only, then this
>>> modification makes it support 32bit and 64bit system both.
>>>
>>> Signed-off-by: Xulei <B33228@freescale.com>
>>
>> This been build or run tested?
>
> Yes, Any issues with me applying this via the powerpc.git tree?

I'm concerned about the fact that we have to have two defines to
declare code that is 32-bit and 64-bit clean.  Technically speaking,
all drivers should work in both environments.  It seems silly to have
"PPC32 || PPC64" for everything.  Isn't there a generic "PPC" config
option that covers this?

-- 
Timur Tabi
Linux kernel developer at Freescale
