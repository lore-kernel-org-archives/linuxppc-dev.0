Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id 385EFDDE0D
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jan 2007 11:42:32 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1008999ugf
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jan 2007 16:42:31 -0800 (PST)
Message-ID: <528646bc0701131642w5a57607aha4e64e8ec4dcaa2e@mail.gmail.com>
Date: Sat, 13 Jan 2007 17:42:30 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Make it blatently clear;
	5200 device tree is not yet stable
In-Reply-To: <84dba8e3e19d453c2961c4022ddb77de@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <11687326992407-git-send-email-grant.likely@secretlab.ca>
	<84dba8e3e19d453c2961c4022ddb77de@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/13/07, Segher Boessenkool <segher@kernel.crashing.org> wrote:
> > Please apply for 2.6.20.  This is documentation only, but I don't want
> > to give people false assumptions about the stability of the 5200 device
> > tree bindings
>
> Good idea.

Thanks.  :)

> > +********** DRAFT ***********
> > +* WARNING: Do not depend on definiton remaining static between
> > +* kernel versions.  The 5200 device tree conventions are still in flux
> > +* and could change without notice.  Keep an eye on the linuxppc-dev
> > +* mailing list for more details
> > +*
> > +* Hopefully by 2.6.21 it will be stable.  ---gcl, Jan 13, 2007
> > +********** DRAFT ***********
>
> But could you please rephrase in a way that doesn't suggest
> the *kernel* defines what the device bindings are?  They are
> only documented in the kernel tree right now, sure, but that's
> not the same thing ;-)

Gah!  Good point.  I do *not* what to go down the "this is for Linux
only" path.  In fact, perhaps I should start looking for a better
place to host this stuff.   Maybe freescale or power.org?

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
