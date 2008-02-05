Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id C65B6DDFD6
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Feb 2008 03:34:35 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so765839anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 05 Feb 2008 08:34:33 -0800 (PST)
Message-ID: <fa686aa40802050824y2a650231j3889b749d3553701@mail.gmail.com>
Date: Tue, 5 Feb 2008 09:24:33 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "A. Nolson" <alohanono@gmail.com>
Subject: Re: Problems booting in ML403
In-Reply-To: <47A8782E.4050402@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47A8782E.4050402@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 2/5/08, A. Nolson <alohanono@gmail.com> wrote:
> Hello,
>
>  I am having problems while trying to boot my linux kernel 2.6.24-rc3 (
> secretlab git). After some days studying this list and other related
> documents/wikis about how to make work a linux kernel in my ML403, I
> managed to make it work partially.
>
<snip>
>
>
> Linux/PPC load: console=ttyS0,9600 console=tty0,9600 console=ttyUL0,9600
> root=/d
> ev/xsa2 rw
> init=/sbin/init

What happens if you try init=/bin/sh?

What does your /etc/inittab look like?

It looks like the system is booting, but inittab might not be starting
any processes attached to the serial console.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
