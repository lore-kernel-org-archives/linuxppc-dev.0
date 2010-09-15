Return-Path: <tanderson@curtisswright.com>
Received: from mail152.messagelabs.com (mail152.messagelabs.com
	[216.82.253.19])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail152.messagelabs.com",
	Issuer "MessageLabs" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7394BB70A5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 05:13:33 +1000 (EST)
From: "Anderson, Trevor" <tanderson@curtisswright.com>
To: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>, Andrew Morton
	<akpm@linux-foundation.org>
Date: Wed, 15 Sep 2010 15:13:27 -0400
Subject: RE: [PATCH v2 09/10] RapidIO: Add support for IDT CPS Gen2 switches
Message-ID: <1682399277683944B902B3657D2FCE216544F4A20D@CAREXCLUSTER03.ATL.CW.LOCAL>
References: <1284476363-1677-1-git-send-email-alexandre.bounine@idt.com><1284476363-1677-10-git-send-email-alexandre.bounine@idt.com><20100914152049.8d42783f.akpm@linux-foundation.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E5520130321F@CORPEXCH1.na.ads.idt.com>
	<1682399277683944B902B3657D2FCE216544F4A1F0@CAREXCLUSTER03.ATL.CW.LOCAL>
	<0CE8B6BE3C4AD74AB97D9D29BD24E5520130332B@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <0CE8B6BE3C4AD74AB97D9D29BD24E5520130332B@CORPEXCH1.na.ads.idt.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Thomas Moll <thomas.moll@sysgo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Bounine, Alexandre [mailto:Alexandre.Bounine@idt.com]
> Sent: Wednesday, September 15, 2010 11:53 AM
> To: Anderson, Trevor; Andrew Morton
> Cc: linux-kernel@vger.kernel.org; Thomas Moll; linuxppc-dev@lists.ozlabs=
.org
> Subject: RE: [PATCH v2 09/10] RapidIO: Add support for IDT CPS Gen2 swit=
ches
>
> Anderson, Trevor <tanderson@curtisswright.com> wrote:
> >
> > Keep it in please. We lurkers in the embedded community do use the
> per-port routing tables.
> > One of the problems with SRIO switch tables is that access to routes
> is not atomic; we can use
> > restricted access to per-port routing tables to reduce the risk of
> interference. And we still use
> > the Global table during enumeration.
> >
> Will it help if I add sysfs attribute(s) to handle per-port routes?

I don't think so - not from my perspective, at least. All of our routes
are programmed using the broadcast table; but we use the private tables
as a safer method of reading the routes that have been programmed, when we=

need to know that.



_______________________________________________________________________
This e-mail and any files transmitted with it are proprietary and intended=
 solely for the use of the individual or entity to whom they are addressed=
. If you have reason to believe that you have received this e-mail in erro=
r, please notify the sender and destroy this email and any attached files.=
 Please note that any views or opinions presented in this e-mail are solel=
y those of the author and do not necessarily represent those of the Curtis=
s-Wright Corporation or any of its subsidiaries.  Documents attached heret=
o may contain technology subject to government export regulations. Recipie=
nt is solely responsible for ensuring that any re-export, transfer or disc=
losure of this information is in accordance with applicable government exp=
ort regulations.  The recipient should check this e-mail and any attachmen=
ts for the presence of viruses. Curtiss-Wright Corporation and its subsidi=
aries accept no liability for any damage caused by any virus transmitted b=
y this e-mail.
