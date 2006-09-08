Return-Path: <jcrigby@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by ozlabs.org (Postfix) with ESMTP id 5CC3A67B9B
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Sep 2006 00:18:47 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id i2so674678nfe
	for <linuxppc-dev@ozlabs.org>; Fri, 08 Sep 2006 07:18:45 -0700 (PDT)
Message-ID: <4b73d43f0609080718g743b9e6bje7202e5293c0abaa@mail.gmail.com>
Date: Fri, 8 Sep 2006 08:18:45 -0600
From: "John Rigby" <jcrigby@gmail.com>
To: "Vaidyanathan S" <svaidy@in.ibm.com>
Subject: Re: powerpc power management
In-Reply-To: <450121E2.5050207@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4b73d43f0609071905j26ab0317k144d78963e041cba@mail.gmail.com>
	<450121E2.5050207@in.ibm.com>
Cc: linuxppc <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

MPC5200 which has a 603 core.

On 9/8/06, Vaidyanathan S <svaidy@in.ibm.com> wrote:
> Hi John,
>
> John Rigby wrote:
> > I need to implement suspend to ram (sleep mode) on an embedded powerpc
> > processor.  I have googled generally and searched the lkml, this list
> > and the linux power management mailing list.  It seems after all this
> > searching that the only existing code is for the powermac in
> > drivers/macintosh/(variousfiles) and
> > arch/powerpc/platforms/powermac/(variousfiles).  Is this true or am I
> > missing something?
> >
>
> Powermac code related to apple platforms seems to be the only
> supported platform for pwr mgt under Linux.
>
> What ppc platforms are you looking at?
>
> > Thanks
> > John
>
> -- Vaidy
>
>
