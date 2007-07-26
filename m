Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by ozlabs.org (Postfix) with ESMTP id C53F3DDF34
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 05:55:36 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so746986wag
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 12:55:36 -0700 (PDT)
Message-ID: <fa686aa40707261255x23b06ff4y5fe1527f72c09c5b@mail.gmail.com>
Date: Thu, 26 Jul 2007 13:55:35 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: help with ppc sections?
In-Reply-To: <46A8F22E.6010701@nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <46A8F22E.6010701@nortel.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/26/07, Chris Friesen <cfriesen@nortel.com> wrote:
>
> Hi all,
>
> I'm porting kprobes to 2.6.14, and I think I've got it mostly done.  The
> last thing that I want to do is to mark flush_icache_range() as part of
> the .kprobes.text section so that we don't accidently try to probe it.

Hey Chris,

Mild question; What the *@*#^$! are you doing trying to backport to a
2 year old kernel?!?  :-)


>
> On ppc64 this was done by duplicating the _GLOBAL macro and just
> modifying the ".section" line.
>
> Unfortunately for me, ppc doesn't have a ".section" line in that macro,
> so I'm at a bit of a loss.

Just add the section.  Should be trivial to do.  You might have to add
it to the linker script as well.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
