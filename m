Return-Path: <jcrigby@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id DF63F67A2E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Jul 2006 03:36:58 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id e2so368779ugf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Jul 2006 10:36:56 -0700 (PDT)
Message-ID: <4b73d43f0607271030o7170e8dcn28bd3f62ec243426@mail.gmail.com>
Date: Thu, 27 Jul 2006 11:30:42 -0600
From: "John Rigby" <jcrigby@gmail.com>
To: "Sylvain Munaut" <tnt@246tnt.com>
Subject: Re: Using bestcomm in an external module (MPC5200B to be exact)
In-Reply-To: <44BC0B9A.5010103@246tNt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4496b9a7.1d040e45.6737.ffff8473@mx.gmail.com>
	<20060620210335.q9mgydr5ppkogsoo@webmail.bluenox.com>
	<1151710395.27137.7.camel@localhost.localdomain>
	<44BC0B9A.5010103@246tNt.com>
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

Sylvain,

How can I help getting the mpc5200 migrated to the powerpc tree?
I should have some time to help with this.

After we get it migrated we can get the bestcomm code in and
the various drivers that use it.

Also, did you ever get a liteb board?  If not send me your address
and I will try again to get you one.

Thanks
John

On 7/17/06, Sylvain Munaut <tnt@246tnt.com> wrote:
> Benjamin Herrenschmidt wrote:
> >> But anyway, it's mainly internal cleanup and adapting drivers
> >> from the public version on my git tree to this newest/cleaner
> >> version is a 15 min work ;)
> >>
> >
> > Any reason why you aren't regulary submitting those patches for upstream
> > inclusion ?
> >
> Yes. What's in there and not in main streams adds quite a lot to
> arch/ppc ... So
> MPC5200 should be adapted to arch/powerpc first and then those changes.
> And since
> no-one did that yet and I haven't done it yet either ... (I must admit I
> had a quick look
> and I didn't understand much on how to do the change ...)
>
>
>     Sylvain
>
>
> PS: Sorry for the lag (like 15 days...) you know email
> problem/appartement change/vacation/... the usual ;)
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
