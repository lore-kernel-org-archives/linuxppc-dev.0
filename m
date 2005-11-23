Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id E35DC687E3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 07:14:50 +1100 (EST)
To: "Dan Wilson" <dwilson@dslextreme.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 23 Nov 2005 08:16:40 PST."
	<200511230816400937.2B36A589@smtp.dslextreme.com>
Date: Wed, 23 Nov 2005 21:14:48 +0100
Sender: wd@denx.de
Message-Id: <20051123201448.7D6DE353A43@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Freescale 8541 support 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <200511230816400937.2B36A589@smtp.dslextreme.com> you wrote:
> 
> Thanks for the reply!  Unfortunately, I am constrained to use the 2.4
>  kernel by another software package that I have to use, which doesn't yet
>  support 2.6.  It appears to me that the 8541/8555 support was put into 2.6
>  and never back-ported to 2.4.  I'll take a look at the manuals today and

Yes. We will add specific board support for the 8541/8555  (in  terms
of the TQM8541 and TQM8555 boards) to our 2.6 git repository in a few
days, but we don't have any intentions to support these boards in our
2.4 tree (unless you pay us for it, of course :-)

>  compare the 8540 to the 8541: perhaps I can live with the 8540 support
>  that does appear to be in the 2.4 kernel.  If not, hopefully the porting
>  job won't be very difficult.

It's just a routine job, but it takes time  and  resources,  and  you
have  to  decide  if  it makes sense to invest these in a kernel tree
that will not be developed any further.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Our business is run on trust.  We trust you will pay in advance.
