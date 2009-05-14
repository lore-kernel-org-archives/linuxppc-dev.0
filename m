Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.239])
	by ozlabs.org (Postfix) with ESMTP id 3ADA4DE04E
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 02:11:19 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f9so753451rvb.9
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 09:11:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A0C40D4.1090508@freescale.com>
References: <1241560385-26868-1-git-send-email-timur@freescale.com>
	<fa686aa40905140813l5caf7085r64bce935be0a22d3@mail.gmail.com>
	<4A0C40D4.1090508@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 14 May 2009 10:10:57 -0600
Message-ID: <fa686aa40905140910i194acbd7y34142720874b8299@mail.gmail.com>
Subject: Re: [PATCH v7] introduce macro spin_event_timeout()
To: Timur Tabi <timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, smaclennan@pikatech.com, scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 14, 2009 at 10:03 AM, Timur Tabi <timur@freescale.com> wrote:
> Grant Likely wrote:
>
>> This version looks good to me. =A0Who's the first user? (I'd like to see
>> that something is ready to use this before merging it)
>
> I was going to do it the other way around - wait until this patch is merg=
ed, and then update some code to use it. =A0After all, it's easier to use a=
 macro if it already exists in a header file. :-)

Heh, I think you miss my meaning.  Of course this patch must be merged
before any users.  I just want to hold off merging it until I see
viable patches on the mailing list which depend on it.

In other words, write your patches which use it and submit the lot as
a patch series with this patch as the first.  That gives some evidence
that this macro will actually be used and useful.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
