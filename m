Return-Path: <tnt@246tNt.com>
Received: from outmx014.isp.belgacom.be (outmx014.isp.belgacom.be
	[195.238.4.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BCF84DDF5F
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2007 02:46:45 +1100 (EST)
Received: from outmx014.isp.belgacom.be (localhost [127.0.0.1])
	by outmx014.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l08FkVaI016505
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Jan 2007 16:46:31 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45A266D7.8090008@246tNt.com>
Date: Mon, 08 Jan 2007 16:44:23 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [PATCH] Probe Efika platform before CHRP.
References: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>		<1166528379.19254.69.camel@localhost.localdomain>		<4587D338.7060906@246tNt.com>		<1166538553.25827.99.camel@pmac.infradead.org>		<1166558300.19254.71.camel@localhost.localdomain>		<1167773388.22068.443.camel@pmac.infradead.org>		<1167773863.6165.82.camel@localhost.localdomain>		<1167775493.3660.23.camel@shinybook.infradead.org>		<528646bc0701021504k88682bl765fad4c100bd40e@mail.gmail.com>		<45A01416.6080401@genesi-usa.com>		<528646bc0701061423o270df3dfj9d27d5572840ec79@mail.gmail.com>		<45A1535C.1080007@genesi-usa.com>	<1168222654.14763.92.camel@shinybook.infradead.org>	<45A20C66.8060506@genesi-usa.com>
	<45A23E8E.7010209@246tNt.com>
In-Reply-To: <45A23E8E.7010209@246tNt.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: bbrv@genesi-usa.com, David Woodhouse <dwmw2@infradead.org>,
	Paul Mackerras <paulus@samba.org>, Linux PPC DEV <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sylvain Munaut wrote:
> 1) What I think should absolutely be fixed : (non compliancy
> with the ieee1275 document are marked as bug) :
>  - PSC init (for PSC2 and PSC6 you said as well): Theses
>    are obviously bugs, no argument there.
>  - Missing IRQ for the sound node : Again, this is obviously
>    missing, the interrupt does exists and it should be in the
>    dt, whether or not you think the driver will use it or not.
>  - Partition numbering problem (again, an obvious bug)
>  - Double \0 : This one is a bug (just confirmed it re-reading
>    the specs) Altough I must admit the kernel just won't care
>    it's nevertheless a bug and should be
>  - "chrp" type : If I understood correctly your previous mail
>    you're ok with it.
>  - "memory" type of the SRAM: I quote the 1275.pdf, section
>    3.7.6 : "In this context, 'memory' refers to traditional
>    RAM, suitable for temporary storage of data". I think we
>    can agree sram is not conventionnal RAM. You're free (and
>    should) still use the reg and available property but not
>    the type ram. I must also say that the current fixup I
>    implemented doesn't really work because this can only be
>    fixed too late ... (node already processed and added as
>    normal memory).
>   
Oops, forgot something here as well :
 Check for typo, for example "#interuppt-cells" vs "#interrupt-cells"


    Sylvain
