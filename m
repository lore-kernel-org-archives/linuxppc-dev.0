Return-Path: <glikely@secretlab.ca>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.178])
	by ozlabs.org (Postfix) with ESMTP id 2B5C3DDD0C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Aug 2007 23:06:32 +1000 (EST)
Received: by el-out-1112.google.com with SMTP id r27so408109ele
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Aug 2007 06:06:30 -0700 (PDT)
Message-ID: <fa686aa40708280606p67fd74p9287d041d955c538@mail.gmail.com>
Date: Tue, 28 Aug 2007 07:06:28 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: schardt <g.schardt@fz-juelich.de>,
	"Linux PPC Linux PPC" <linuxppc-embedded@ozlabs.org>
Subject: Re: Newbie and linux on virtex-II ppc
In-Reply-To: <46D41298.7060109@fz-juelich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <46D2C9A5.9030708@fz-juelich.de>
	<fa686aa40708270609x453092eye6eaf83b65ac2dee@mail.gmail.com>
	<46D2CFFB.6050602@fz-juelich.de>
	<fa686aa40708270719s1fd230e9g188948ef02b3eda7@mail.gmail.com>
	<46D41298.7060109@fz-juelich.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/28/07, schardt <g.schardt@fz-juelich.de> wrote:
> Hi Grant,
>
> i need your help again :)
>
> my 2.6. kernel is running. now i want to add the system ace driver to
> mount a rootfs on the systemace-flash.
> but i don't know how to import the EKD driver to the linux kernel, or is
> there a ready to go driver in the kernel tree ?
> i didn't find anything...

You've got 2 choices:
1. use the new sysace driver; it's already in mainline.  The new
driver is faster, but it doesn't handle hotswap of the CF card (yet)
2. use the EDK driver; easiest way is to use my tree which already has
it merged:  http://git.secretlab.ca

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
