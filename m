Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id D89C1DDE1E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Sep 2008 19:24:23 +1000 (EST)
To: =?iso-8859-9?Q?Mustafa_Cay=FDr?= <mustafa.cayir@bte.mam.gov.tr>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Linux Init Hangs
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <7B9A8FF57DBB524190E98CABF6E56F07DD412C@itri.bte.mam.gov.tr>
References: <7B9A8FF57DBB524190E98CABF6E56F07DD412C@itri.bte.mam.gov.tr>
Date: Fri, 26 Sep 2008 11:24:20 +0200
Sender: wd@denx.de
Message-Id: <20080926092420.BAB7E248CD@gemini.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear =?iso-8859-9?Q?Mustafa_Cay=FDr?=,

In message <7B9A8FF57DBB524190E98CABF6E56F07DD412C@itri.bte.mam.gov.tr> you wrote:
>
> my kernel hangs by initializing the system. My target is mpc7457-based. =
> I use ELDK 3.1.1 and mount my root-fs over nfs.

ELDK 3.1.1 is vry old - and it means that you must be using a 2.4
Linux kernel, whichis also very old.

Please consider updating to current versions.

> After printing the message "Freeing unused kernel memory: 112k init", it
> hangs Any ideas?

You provide very little information, so we can only speculate.

Are you sure that /dev/console exists in your target root file
system, and did you run the ELDK_MAKEDEV script when installing the
ELDK?

Also, did you pass the appropriate console=... boot argument to the
Linux kernel?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Always try to do things in chronological order; it's  less  confusing
that way.
