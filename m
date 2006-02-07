Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 6F6F9689D9
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Feb 2006 08:04:23 +1100 (EST)
To: Josh Boyer <jwboyer@jdub.homelinux.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Common Flash Interface v1.4 and MTD support in Linux-2.4.4 kernel
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 07 Feb 2006 05:52:57 EST."
	<1139309578.32218.7.camel@yoda.jdub.homelinux.org>
Date: Tue, 07 Feb 2006 22:04:21 +0100
Sender: wd@denx.de
Message-Id: <20060207210421.57015352659@atlas.denx.de>
Cc: David Antliff <David_Antliff@stratexnet.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <1139309578.32218.7.camel@yoda.jdub.homelinux.org> you wrote:
>
> > What would you suggest? Yes, I am happy for a 'quick fix' but if there
> > isn't one or it's too risky I am willing to invest the time in doing it
> > right.
> 
> 'quick fix' is to pull the changes from cfi_cmdset_0001.c in MTD CVS
> back into your kernel.  But I'm not sure how quick that will be given
> that your kernel is very very old.

It's not quick at all, and the  ancient  2.4.4  MTD  code  has  other
problems  at  all.  Swithing to a newer kernel version is very likely
less trouble.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
If you believe that feeling bad or worrying long enough will change a
past or future event, then you are residing on another planet with  a
different reality system.
