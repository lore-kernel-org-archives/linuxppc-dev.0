Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 422D3B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 15:33:00 +1000 (EST)
Subject: Re: powerpc: mpc85xx regression since 2.6.39-rc2, one cpu core lame
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1305755338.7481.8.camel@pasglop>
Date: Thu, 19 May 2011 00:32:48 -0500
Message-Id: <369C774C-DF3B-4D8E-BABF-B1C9727AE96E@kernel.crashing.org>
References: <20110517162827.GA16918@riccoc20.at.omicron.at>
	<1305668416.2781.23.camel@pasglop>
	<20110518120320.GA3025@riccoc20.at.omicron.at>
	<1305755338.7481.8.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Richard Cochran <richardcochran@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 18, 2011, at 4:48 PM, Benjamin Herrenschmidt wrote:

>=20
>> (I get the feeling that I am the only one testing recent kernels with
>> the mpc85xx.)
>>=20
>> Anyhow, I see that this commit was one of a series. For my own use,
>> can I simply revert this one commit independently?
>=20
> For your own use sure :-) But I'd still like to get to the bottom of
> this !
>=20
> Cheers,
> Ben.

Tested the 'merge' branch and it appears to fix the issues with =
secondary cores coming up.

- k=
