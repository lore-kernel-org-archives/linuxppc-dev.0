Return-Path: <patrickdepinguin@gmail.com>
Received: from mail-qy0-f177.google.com (mail-qy0-f177.google.com
	[209.85.216.177]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D80D2B6EDF
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Jun 2011 22:54:00 +1000 (EST)
Received: by qyk7 with SMTP id 7so502627qyk.15
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Jun 2011 05:53:56 -0700 (PDT)
MIME-Version: 1.0
Sender: patrickdepinguin@gmail.com
In-Reply-To: <4E01D4AB.3010505@freescale.com>
References: <BANLkTikd3ZtNRcz=ZWSsDL9OoeV0Wndy1g@mail.gmail.com>
	<BANLkTinOxqF=TcBxQOsfJSot-1XH3iErXA@mail.gmail.com>
	<BANLkTimhKOvY8XA=_20rjtkZ0Um45o2Bow@mail.gmail.com>
	<4DF7BE43.1010407@freescale.com> <4DF7BF84.8030000@freescale.com>
	<BANLkTikcn7ghNF7YW7LO+=Qs_4A=RHxJSQ@mail.gmail.com>
	<4E01D4AB.3010505@freescale.com>
Date: Wed, 22 Jun 2011 14:53:56 +0200
Message-ID: <BANLkTinn+Eepq=XL9PuMnffsxKC1jY2+Kg@mail.gmail.com>
Subject: Re: Mapping an executable page
From: Thomas De Schampheleire <patrickdepinguin+linuxppc@gmail.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 22, 2011 at 1:40 PM, Tabi Timur-B04825 <B04825@freescale.com> wrote:
> Thomas De Schampheleire wrote:
>> I think I can make it more reliable by dummy reading the pages*after*
>> I disabled interrupts on that processor, immediately before jumping to
>> the boot code. Is that correct?
>
> That sounds logical to me.
>
> BTW, since you're already doing something non-standard with your module, why
> don't you just make settlbcam exported?

It's not because I need to do something non-standard that I like to
disregard any rule, convention, or good practice :-)
I prefer to follow the kernel 'rules' and practices as closely as
possible, primarily by not messing with the kernel at all.
Unfortunately, in this case, there does not seem to be another way.

Exporting settlbcam causes me to make kernel changes (not module
changes). Then, if I want to update to a newer kernel version, I have
to re-apply the change.
By using a kernel module in a 'standard' way, I limit the number of
upgrade issues.

Best regards,
Thomas
