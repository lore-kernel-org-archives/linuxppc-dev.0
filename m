Return-Path: <kumar.gala@freescale.com>
Received: from ftpbox.mot.com (ftpbox.mot.com [129.188.136.101])
	by ozlabs.org (Postfix) with ESMTP id 313072BF22
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Nov 2004 10:20:54 +1100 (EST)
In-Reply-To: <20041109163726.30776.qmail@web53808.mail.yahoo.com>
References: <20041109163726.30776.qmail@web53808.mail.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <73CDD492-326F-11D9-9710-000393DBC2E8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 9 Nov 2004 10:50:24 -0600
To: "annamaya" <annamaya@yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8xx binaries running on a MPC82xx board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

One of the main issues that occurs when trying to run applications from=20=

8xx to 82xx is dealing with the difference in cache line size.  If code=20=

is written properly this difference will be invisible to the user.  It=20=

might be that 8xx code is not as optimal on 82xx because of it.

Also since you are going from 8xx -> 82xx your applications most likely=20=

are all integer code.  Going from 82xx -> 8xx may not be as successful.

- kumar

On Nov 9, 2004, at 10:37 AM, annamaya wrote:

> I was under the assumption that the MPC8xx core was
>  different from the MPC82xx core (the 603e?). But I was
>  surprised to find that the MPC8xx binaries were
>  running fine on a MPC82xx binaries, even if they were
>  dynamically linked and were linking to the MPC82xx
>  libraries. What's going on here? Can I just use the
>  8xx toolkit to work with the 82xx? There must be SOME
> differences between these two architectures. Can
>  someone here explain this to me?
>
>
>
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0
>  __________________________________
>  Do you Yahoo!?
> Check out the new Yahoo! Front Page.
> www.yahoo.com
>  =A0
>
> _______________________________________________
> Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
