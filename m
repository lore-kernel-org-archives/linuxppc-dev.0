Return-Path: <leon.woestenberg@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2ADE0B7243
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 21:45:50 +1000 (EST)
MIME-Version: 1.0
In-Reply-To: <EEB9B7B7-5456-4AE9-8BB9-96DA04320697@kernel.crashing.org>
References: <4A39DC80.7030906@arvoo.nl>
	<20090618130955.GA1369@oksana.dev.rtsoft.ru>
	<EEB9B7B7-5456-4AE9-8BB9-96DA04320697@kernel.crashing.org>
Date: Fri, 19 Jun 2009 13:45:46 +0200
Message-ID: <c384c5ea0906190445u130a4fedv14c22c7f9abdb9d8@mail.gmail.com>
Subject: Re: [PATCH -mm][POWERPC] mpc8xxx : allow SPI without cs.
From: Leon Woestenberg <leon.woestenberg@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: spi-devel-general@lists.sourceforge.net, Rini van Zetten <rini@arvoo.nl>,
	linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Thu, Jun 18, 2009 at 4:04 PM, Kumar Gala<galak@kernel.crashing.org> wrot=
e:
> On Jun 18, 2009, at 8:09 AM, Anton Vorontsov wrote:
>> On Thu, Jun 18, 2009 at 08:19:44AM +0200, Rini van Zetten wrote:
>>>
>>> This patch adds the possibility to have a spi device without a cs.
>>>
> That is a good question. =A0What HW is this for (I don't think its for eS=
PI
> but I could be wrong).
>
We need SPI without CS too on our MPC8313E design.

In our case having a CS line to each slave (18 of them) is too
expensive and we use a chip select which piggy backs on another
signal.
Once the slave is selected, SPI is used to send large amounts of data.

Regards,
--=20
Leon
