Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 4CA61DDDFA
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Oct 2008 09:48:44 +1000 (EST)
To: "sumedh tirodkar" <sumedhtirodkar@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: SA-RTLinux for ppc?
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <d2b9ccd90810030835m534f7619xe0be08078bad0019@mail.gmail.com>
References: <0B45E93C5FF65740AEAE690BF3848B7AD383BB@rennsmail04.eu.thmulti.com>
	<d2b9ccd90810030835m534f7619xe0be08078bad0019@mail.gmail.com>
Date: Sat, 04 Oct 2008 01:48:39 +0200
Sender: wd@denx.de
Message-Id: <20081003234839.3774F2480D@gemini.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear "sumedh tirodkar",

In message <d2b9ccd90810030835m534f7619xe0be08078bad0019@mail.gmail.com> you wrote:
>
> actually i m tryin to find a linux like port for powerpc.
> lookin for a kernel which has very less functionalities.

That's what Fillod recommended to you:

> On Fri, Oct 3, 2008 at 9:01 PM, Fillod Stephane <stephane.fillod@thomson.net
> >
> > I don't know, but there's a very good hard real-time extension called
> > Xenomai
> > for powerpc (and many other arch's). http://www.xenomai.org

If you need support for hard real-time behaviour in Linux, then use
Xenomai.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Only in our dreams we are free.  The rest of the time we need  wages.
                                    - Terry Pratchett, _Wyrd Sisters_
