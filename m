Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 408DEDDF38
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Apr 2007 03:17:33 +1000 (EST)
To: "Gary Kenaley" <gkenaley@echelon.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Unable to Boot 2.6.19.2 from ELDK 4.1 on MPC8349E MDS 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 09 Apr 2007 18:33:30 PDT."
	<DDBD7B17DB2ECE48BCD94C593F7255B4046E9F23@monk.echelon.echcorp.com>
Date: Tue, 10 Apr 2007 19:17:24 +0200
Sender: wd@denx.de
Message-Id: <20070410171724.B0CDF353B4B@atlas.denx.de>
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

In message <DDBD7B17DB2ECE48BCD94C593F7255B4046E9F23@monk.echelon.echcorp.com> you wrote:
>
...
[Comments on questions already answered by Ben Warren omitted.]
> 
> I also tried a "full source rebuild from scratch" for the ELDK 4.1, but
> I found that these SRPMS were originally misnamed (could not be found in
> CVS, rpmfind, or the ELDK source CD-ROM) in
> /home/gkenaley/ELDK/V4.1/build/SRPMS.lst:

You misunderstand. Please read the documentation. The SRPMs listed in
SRPMS.lst are the original Fedora Core SRPMs which are used as  input
to  the  ELDK  build  process.  The SRPMs on the Source CDROM are the
source RPMs created by the ELDK build, i. e. it's output.

> After correcting (?) SRPMS.lst to contain the names shown above, the

You did not correect it, you corrupted it instead.

> 2. Any idea why I have problems doing the "ELDK 4.1 full source rebuild
> from scratch"?

Because you did not follow the documentation.

Note that you should use either RedHat Linux 7.3  or  Fedora  Core  5
(both  with  all  updates  installed) as build environment - at least
these are the only officially supported build environments.


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Power is danger.
	-- The Centurion, "Balance of Terror", stardate 1709.2
