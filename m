Return-Path: <svaidy@in.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 15A8167B82
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Sep 2006 17:55:45 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp05.au.ibm.com (8.13.6/8.13.6) with ESMTP id k887wBsd8925398
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Sep 2006 17:58:11 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by sd0109e.au.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k887wvqe123920
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Sep 2006 17:59:01 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k887tIwr014621
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Sep 2006 17:55:19 +1000
Message-ID: <450121E2.5050207@in.ibm.com>
Date: Fri, 08 Sep 2006 13:25:14 +0530
From: Vaidyanathan S <svaidy@in.ibm.com>
MIME-Version: 1.0
To: John Rigby <jcrigby@gmail.com>
Subject: Re: powerpc power management
References: <4b73d43f0609071905j26ab0317k144d78963e041cba@mail.gmail.com>
In-Reply-To: <4b73d43f0609071905j26ab0317k144d78963e041cba@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi John,

John Rigby wrote:
> I need to implement suspend to ram (sleep mode) on an embedded powerpc
> processor.  I have googled generally and searched the lkml, this list
> and the linux power management mailing list.  It seems after all this
> searching that the only existing code is for the powermac in
> drivers/macintosh/(variousfiles) and
> arch/powerpc/platforms/powermac/(variousfiles).  Is this true or am I
> missing something?
> 

Powermac code related to apple platforms seems to be the only
supported platform for pwr mgt under Linux.

What ppc platforms are you looking at?

> Thanks
> John

-- Vaidy
