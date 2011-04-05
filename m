Return-Path: <balbi@ti.com>
Received: from na3sys009aog113.obsmtp.com (na3sys009aog113.obsmtp.com
	[74.125.149.209])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 44F3AB6F99
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Apr 2011 18:12:29 +1000 (EST)
Received: by eyg24 with SMTP id 24so43741eyg.11
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 05 Apr 2011 01:12:25 -0700 (PDT)
Date: Tue, 5 Apr 2011 11:12:22 +0300
From: Felipe Balbi <balbi@ti.com>
To: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: Re: [PATCH v10 03/10] USB/ppc4xx: Add Synopsys DWC OTG Core
	Interface Layer (CIL)
Message-ID: <20110405081221.GE2176@legolas.emea.dhcp.ti.com>
References: <1301336866-1915-1-git-send-email-tmarri@apm.com>
	<3569ce83abe4f1f3ab1699c2beee1f35@mail.gmail.com>
	<712525e420e78daeb3f43bf1ebc53e23@mail.gmail.com>
	<4D961FBA.8090107@ru.mvista.com>
	<b284084fc5fc0d15e13cbfaf926ee1ce@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b284084fc5fc0d15e13cbfaf926ee1ce@mail.gmail.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, Tirumala Marri <tmarri@apm.com>,
	greg@kroah.com, linux-usb@vger.kernel.org,
	Mark Miesfeld <mmiesfeld@apm.com>, linuxppc-dev@lists.ozlabs.org,
	Fushen Chen <fchen@apm.com>
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 05, 2011 at 12:38:03PM +0530, Keshava Munegowda wrote:
> > -----Original Message-----
> > From: Sergei Shtylyov [mailto:sshtylyov@mvista.com]
> > Sent: Saturday, April 02, 2011 12:26 AM
> > To: Tirumala Marri
> > Cc: Keshava Munegowda; linux-usb@vger.kernel.org;
> linuxppc-dev@lists.ozlabs.org; greg@kroah.com;
> > Fushen Chen; Mark Miesfeld
> > Subject: Re: [PATCH v10 03/10] USB/ppc4xx: Add Synopsys DWC OTG Core
> Interface Layer (CIL)
> >
> > Hello.
> >
> > Tirumala Marri wrote:
> >
> > >>> +void dwc_otg_core_init(struct core_if *core_if)
> > >>> +{
> > >>> +	u32 i;
> > >>> +	ulong global_reg = core_if->core_global_regs;
> > >>> +	struct device_if *dev_if = core_if->dev_if;
> > >>> +	u32 ahbcfg = 0;
> > >>> +	u32 i2cctl = 0;
> > >>> +	u32 gusbcfg;
> >
> > >> Tabify the declarations ;
> >
> > > [Marri] When I checked again in my source, I do see the tabs added
> before
> > > declarations.
> >
> >     He means that tabs should be between the variable's type and name,
> but
> > there's no such requirement actually.
> 
> I am sorry if there is no such requirement, since I had such comments and
> I fixed it and
> Now I have commented.

it's true we don't have that requirement, but it does look better when
we have many local variables. IMHO, whatever we can do to go easy on the
eyes, we should.

-- 
balbi
