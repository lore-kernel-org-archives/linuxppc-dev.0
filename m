Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6810AB6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Oct 2010 16:31:29 +1100 (EST)
Subject: Re: [RFC] arch/powerpc: Remove duplicate/redundant Altivec entries
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100908015916.GB17010@brick.ozlabs.ibm.com>
Date: Thu, 7 Oct 2010 00:31:18 -0500
Message-Id: <5EF3711D-EC6B-4A09-99AF-735FCFEB315D@kernel.crashing.org>
References: <1283885815-11175-1-git-send-email-msm@freescale.com>
	<20100908015916.GB17010@brick.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Matthew McClintock <msm@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 7, 2010, at 8:59 PM, Paul Mackerras wrote:

> On Tue, Sep 07, 2010 at 01:56:55PM -0500, Matthew McClintock wrote:
>=20
>> In lieu of having multiple similiar lines, we can just have one
>> generic cpu-as line for CONFIG_ALTIVEC
>>=20
>> ---
>> Was hoping to get comments about this change and if anyone sees any =
potential
>> problems?
>=20
> I have a memory that we can get some altivec instructions even with
> CONFIG_ALTIVEC =3D n, though presumably they never get executed.  We
> would have to check that before applying your patch.

How would we check that?

- k=
