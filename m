Return-Path: <SRS0=8W1B=Q3=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id A027CDDE1B
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Dec 2007 20:27:23 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: Dell Query <dell.query@yahoo.com>
Subject: Re: Unable to Read PPC440EPx Board ID thru Board Control and Status
	Registers (BCSR)
Date: Tue, 4 Dec 2007 10:28:07 +0100
References: <86675.82133.qm@web45613.mail.sp1.yahoo.com>
In-Reply-To: <86675.82133.qm@web45613.mail.sp1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200712041028.07380.sr@denx.de>
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

On Monday 03 December 2007, Dell Query wrote:
> I finally got the new pdf files from other Resource CDs and used 0xc000000
> address, without 0x2000 offset.

Good.

> It works! Thanks a lot for the help.
>
> But may I know why in Linux it is mapped to 0x1c000000, wherein the doc
> stated 0xc000000?

The doc most probably only refers to the virtual address mapped in U-Boot 
here.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
