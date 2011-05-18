Return-Path: <Eric.Moore@lsi.com>
Received: from na3sys009aog101.obsmtp.com (na3sys009aog101.obsmtp.com
	[74.125.149.67])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2EEC5B6F74
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 05:11:21 +1000 (EST)
From: "Moore, Eric" <Eric.Moore@lsi.com>
To: Milton Miller <miltonm@bga.com>, Hitoshi Mitake <h.mitake@gmail.com>,
	"Sam Ravnborg" <sam@ravnborg.org>, Ingo Molnar <mingo@elte.hu>, Ingo Molnar
	<mingo@redhat.com>, "Desai, Kashyap" <Kashyap.Desai@lsi.com>, "Prakash,
	Sathya" <Sathya.Prakash@lsi.com>
Date: Wed, 18 May 2011 13:11:16 -0600
Subject: RE: [PATCH 1/3] mpt2sas: remove the use of writeq, since writeq is
	not atomic
Message-ID: <4565AEA676113A449269C2F3A549520F80BE7F37@cosmail03.lsi.com>
References: <20110504115324.GE17855@lsi.com>
	<1305616571.6008.23.camel@mulgrave.site>
	<B2FD678A64EAAD45B089B123FDFC3ED70157F7BCE5@inbmail01.lsi.com>
	<20110518041551.GL15227@parisc-linux.org>
	<1305692584.2580.3.camel@mulgrave.site>	<1305702010.2781.33.camel@pasglop>
	<mpt2sas-writeq-powerpc64@mdm.bga.com>
	<4565AEA676113A449269C2F3A549520F80B66280@cosmail03.lsi.com>
	<x86-32-writeq-is-broken@mdm.bga.com>
In-Reply-To: <x86-32-writeq-is-broken@mdm.bga.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: linux-arch <linux-arch@vger.kernel.org>, linux
	scsi dev <linux-scsi@vger.kernel.org>, Matthew Wilcox <matthew@wil.cx>,
	linux kernel <linux-kernel@vger.kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	"paulus@samba.org" <paulus@samba.org>,
	linux pci <linux-pci@vger.kernel.org>,
	linux powerpc dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday, May 18, 2011 12:31 PM Milton Miller wrote:
> Ingo I would propose the following commits added in 2.6.29 be reverted.
> I think the current concensus is drivers must know if the writeq is
> not atomic so they can provide their own locking or other workaround.
>=20


Exactly.
