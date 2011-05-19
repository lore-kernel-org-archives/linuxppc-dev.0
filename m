Return-Path: <roland@purestorage.com>
Received: from na3sys010aog111.obsmtp.com (na3sys010aog111.obsmtp.com
	[74.125.245.90]) by ozlabs.org (Postfix) with SMTP id 5C0FA100933
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 14:22:41 +1000 (EST)
Received: by qyk2 with SMTP id 2so3322225qyk.7
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 18 May 2011 21:22:38 -0700 (PDT)
MIME-Version: 1.0
Sender: roland@purestorage.com
In-Reply-To: <x86-32-writeq-is-broken@mdm.bga.com>
References: <20110504115324.GE17855@lsi.com>
	<1305616571.6008.23.camel@mulgrave.site>
	<B2FD678A64EAAD45B089B123FDFC3ED70157F7BCE5@inbmail01.lsi.com>
	<20110518041551.GL15227@parisc-linux.org>
	<1305692584.2580.3.camel@mulgrave.site>
	<1305702010.2781.33.camel@pasglop>
	<mpt2sas-writeq-powerpc64@mdm.bga.com>
	<4565AEA676113A449269C2F3A549520F80B66280@cosmail03.lsi.com>
	<x86-32-writeq-is-broken@mdm.bga.com>
From: Roland Dreier <roland@kernel.org>
Date: Wed, 18 May 2011 21:16:49 -0700
Message-ID: <BANLkTimDktq8SxOU3HZkPpj=J9pdkzVX-w@mail.gmail.com>
Subject: Re: [PATCH 1/3] mpt2sas: remove the use of writeq, since writeq is
	not atomic
To: Milton Miller <miltonm@bga.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch <linux-arch@vger.kernel.org>, "Prakash,
	Sathya" <Sathya.Prakash@lsi.com>, "Desai, Kashyap" <Kashyap.Desai@lsi.com>,
	linux scsi dev <linux-scsi@vger.kernel.org>,
	Matthew Wilcox <matthew@wil.cx>, Hitoshi Mitake <h.mitake@gmail.com>,
	linux pci <linux-pci@vger.kernel.org>,
	linux powerpc dev <linuxppc-dev@lists.ozlabs.org>,
	linux kernel <linux-kernel@vger.kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ingo Molnar <mingo@redhat.com>, "paulus@samba.org" <paulus@samba.org>,
	Ingo Molnar <mingo@elte.hu>, Sam Ravnborg <sam@ravnborg.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 18, 2011 at 11:31 AM, Milton Miller <miltonm@bga.com> wrote:
> So the real question should be why is x86-32 supplying a broken writeq
> instead of letting drivers work out what to do it when needed?

Sounds a lot like what I was asking a couple of years ago :)
http://lkml.org/lkml/2009/4/19/164

But Ingo insisted that non-atomic writeq would be fine:
http://lkml.org/lkml/2009/4/19/167

 - R.
