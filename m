Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 282D6DDE23
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Oct 2007 20:45:10 +1000 (EST)
Date: Fri, 5 Oct 2007 12:45:27 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Bruce_Leonard@selinc.com
Subject: Re: Device tree and external RTC
In-Reply-To: <OFF5EAF9C9.4E27AE67-ON8825736A.0064875E-8825736A.00652EB0@selinc.com>
Message-ID: <Pine.LNX.4.60.0710051242050.5434@poirot.grange>
References: <OFF5EAF9C9.4E27AE67-ON8825736A.0064875E-8825736A.00652EB0@selinc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Korsgaard <jacmet@gmail.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 4 Oct 2007 Bruce_Leonard@selinc.com wrote:

> A follow on question though.  I've looked at the patch and it seems to be 
> just adding 6 lines to an existing array in fsl_soc.c.  However, I can't 
> seem to find any array in fsl_soc.c that contains lines that the patch 
> indicates should already be there (i.e., there's nothing in fsl_soc.c that 
> has the word "ricoh" in it which the patch indicates it should).  Is my 
> fsl_soc.c already out of date?  Will the patch apply?  I've got 2.6.22.

Ok, we both (Peter and myself) have forgotten, that this change has first 
aooeared after 2.6.22. So, best try 2.6.23-rc9, or use one of the 
git-trees (from Linux or from Paulus, or from Kumar Gala, or...) _plus_ 
the patch we both pointed at.

Thanks
Guennadi
---
Guennadi Liakhovetski
