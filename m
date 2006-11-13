Return-Path: <dvbspider@hotmail.com>
Received: from bay0-omc3-s39.bay0.hotmail.com (bay0-omc3-s39.bay0.hotmail.com
	[65.54.246.239]) by ozlabs.org (Postfix) with ESMTP id 26A4967E93
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Nov 2006 09:29:28 +1100 (EST)
Message-ID: <BAY121-F130E651A04768742C415AA6F40@phx.gbl>
In-Reply-To: <20061113222725.1A79A353B4D@atlas.denx.de>
From: "jhon scoot" <dvbspider@hotmail.com>
To: wd@denx.de, rdreier@cisco.com
Subject: Re: [PATCH] [POWERPC] Add support for Rev. B of PowerPC 440SPe
Date: Mon, 13 Nov 2006 17:29:27 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
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

Roland did u are working on a settop box?  with PPC440


>From: Wolfgang Denk <wd@denx.de>
>To: Roland Dreier <rdreier@cisco.com>
>CC: linuxppc-embedded@ozlabs.org
>Subject: Re: [PATCH] [POWERPC] Add support for Rev. B of PowerPC 440SPe 
>Date: Mon, 13 Nov 2006 23:27:25 +0100
>
>In message <adalkmf44eu.fsf@cisco.com> you wrote:
> > This is mostly updating the PCI Express code to work with the new core
> > in the Rev. B chip, which unfortunately has different undocumented
> > restrictions on the PLB addresses that can be used from the Rev. A core.
> >
> > Also, when adding the cputable entry for 440SPe Rev. B, we need to
> > adjust the entry for 440SP Rev. A so that it looks at more bits of the
> > PVR.  The 440SPe Rev. B has PVR 53421891, which would have matched the
> > old 440SP pattern of 53xxx891.
> >
> > Signed-off-by: Roland Dreier <rolandd@cisco.com>
>
>Just for the record:
>
>This patch is _heavily_ borrowed on code by Rafal Jaworowski; see
>http://www.denx.de/cgi-bin/gitweb.cgi?p=linux-2.6-denx.git;a=commit;h=30e3e3be8863902f508af74fdc61ec9b80756bc0
>
>Please add correct attribution.
>
>Best regards,
>
>Wolfgang Denk
>
>--
>Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
>Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
>"In Christianity neither morality nor religion come into contact with
>reality at any point."                          - Friedrich Nietzsche
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded

_________________________________________________________________
Try Search Survival Kits: Fix up your home and better handle your cash with 
Live Search! 
http://imagine-windowslive.com/search/kits/default.aspx?kit=improve&locale=en-US&source=hmtagline
