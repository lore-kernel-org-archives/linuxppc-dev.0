Return-Path: <rsarmah@apm.com>
Received: from exprod5og106.obsmtp.com (exprod5og106.obsmtp.com [64.18.0.182])
	by ozlabs.org (Postfix) with SMTP id C7C05B6EF1
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Sep 2010 16:29:32 +1000 (EST)
Received: by wwb18 with SMTP id 18so64333wwb.31
	for <linuxppc-dev@ozlabs.org>; Mon, 06 Sep 2010 23:29:29 -0700 (PDT)
From: Rupjyoti Sarmah <rsarmah@apm.com>
References: <20100818205646.57783157D71@gemini.denx.de>
	<20100902061423.19D66153A79@gemini.denx.de>
	607f1313d8b49e06cf3d2f74b8925732@mail.gmail.com
In-Reply-To: 607f1313d8b49e06cf3d2f74b8925732@mail.gmail.com
MIME-Version: 1.0
Date: Tue, 7 Sep 2010 11:59:28 +0530
Message-ID: <5205dc59ca0e0fd65e50d80eeff60d01@mail.gmail.com>
Subject: RE:
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Prodyut Hazarika <phazarika@appliedmicro.com>,
	Mark Miesfeld <mmiesfeld@appliedmicro.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wolfgang,

The current mainline 2.6.36-rc3 does not report any error while building
the SATA driver.

Regards,
Rup


-----Original Message-----
From: Rupjyoti Sarmah [mailto:rsarmah@apm.com]
Sent: Thursday, September 02, 2010 8:22 PM
To: 'Wolfgang Denk'
Cc: 'linuxppc-dev@ozlabs.org'; 'Prodyut Hazarika'; 'Mark Miesfeld'
Subject: RE:

Hi Wolfgang,

Sorry that I did not have a chance to check it recently.

Regards,
Rup

-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de]
Sent: Thursday, September 02, 2010 11:44 AM
To: Rupjyoti Sarmah; Prodyut Hazarika; Mark Miesfeld
Cc: linuxppc-dev@ozlabs.org
Subject: Re:

Dear Rupjyoti, Prodyut, Mark,

two weeks ago I wrote:

In message <20100818205646.57783157D71@gemini.denx.de> you wrote:
>
> drivers/ata/sata_dwc_460ex.c fails to build in current mainline:
...
> Do you have any hints how to fix that?

Any comments or ideas how to fix this?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Time is an illusion perpetrated by the manufacturers of space.
