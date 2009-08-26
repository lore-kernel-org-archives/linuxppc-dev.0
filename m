Return-Path: <glikely@secretlab.ca>
Received: from mail-px0-f190.google.com (mail-px0-f190.google.com
	[209.85.216.190])
	by bilbo.ozlabs.org (Postfix) with ESMTP id CD0D5B7B5C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 03:52:23 +1000 (EST)
Received: by pxi28 with SMTP id 28so382336pxi.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Aug 2009 10:52:22 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <E575F71A-166A-4933-8612-1F0E88A426C5@kernel.crashing.org>
References: <20090826060659.30936.75706.stgit@localhost.localdomain>
	<20090826060716.30936.40578.stgit@localhost.localdomain>
	<E575F71A-166A-4933-8612-1F0E88A426C5@kernel.crashing.org>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 26 Aug 2009 11:52:01 -0600
Message-ID: <fa686aa40908261052k7a725835x9f6f1eb0c1093e0@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] powerpc/pci: Merge ppc32 and ppc64 versions of
	phb_scan()
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 26, 2009 at 7:29 AM, Kumar Gala<galak@kernel.crashing.org> wrot=
e:
>
> On Aug 26, 2009, at 1:07 AM, Grant Likely wrote:
>
>> +/**
>> + * pci_scan_phb - Given a pci_controller, setup and scan the PCI bus
>> + * @hose: Pointer to the PCI host controller instance structure
>> + * @data: value to use for sysdata pointer. =A0ppc32 and ppc64 differ h=
ere
>> + *
>> + * Note: the 'data' pointer is a temporary measure. =A0As 32 and 64 bit
>> + * pci code gets merged, this parameter should become unnecessary becau=
se
>> + * both will use the same value.
>> + */
>> +void __devinit pcibios_scan_phb(struct pci_controller *hose, void *data=
)
>> +{
>> +
>
> Just a nit, but why not data -> sysdata since that's what we using it as.

okay.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
