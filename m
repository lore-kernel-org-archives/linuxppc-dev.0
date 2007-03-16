Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 412ACDDECA
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 21:17:00 +1100 (EST)
To: "Dan Williams" <dan.j.williams@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH] [PPC32] ADMA support for PPC 440SPe processors. 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 15 Mar 2007 22:55:26 MST."
	<e9c3a7c20703152255q16563803q33a5893c210634d1@mail.gmail.com>
Date: Fri, 16 Mar 2007 11:16:58 +0100
Sender: wd@denx.de
Message-Id: <20070316101658.61685352604@atlas.denx.de>
Cc: linux-raid@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <e9c3a7c20703152255q16563803q33a5893c210634d1@mail.gmail.com> you wrote:
>
> They are in -mm (git-md-accel.patch).  I'll review this driver and and
> integrate it into my next push to Andrew, along with some further
> cleanups.

Thanks.

We're doing some cleanup now based on the feedback we receive.

What is easier for you to handle  -  a  complete  new  patch,  or  an
incrementan  one  on  top  of  what  we  submitted  now?  (I'd prefer
incremental, but will do whatever works better for you).

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
You may call me by my name, Wirth, or by my value, Worth.
- Nicklaus Wirth
