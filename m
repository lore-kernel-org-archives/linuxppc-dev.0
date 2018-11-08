Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609E0C32789
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 06:24:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D515620827
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 06:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="pOSuzEFZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D515620827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rCtc1kGMzF3KF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 17:24:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="pOSuzEFZ";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rCkS6w3HzF3HT
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Nov 2018 17:17:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="pOSuzEFZ"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42rCkS3BGKz9s9h; Thu,  8 Nov 2018 17:17:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1541657856;
 bh=eBeokzXtSKg0CjBcsqJffgM0wyR0eyl8rPmPcrDX2RA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pOSuzEFZIkhpS4WI1FD40wjoPhQFOXkFSB+RhBv9CnIr2IDHSvK6Eceb3sPVUQ1et
 KVMH1dDo9JXDSNDAkJJKZonfrdOQyHXnuZTYI/JxTEMUHf9hKVJIOUcmQ0Pr1D7wEG
 Zaf62uqdm0Znpg0PSqJlLTxuT2WrhRKPljBfqNP4=
Date: Thu, 8 Nov 2018 16:18:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel 2/2] powerpc/powernv/pseries: Rework device adding
 to IOMMU groups
Message-ID: <20181108051819.GO5575@umbus.fritz.box>
References: <20181018075243.4798-1-aik@ozlabs.ru>
 <20181018075243.4798-3-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="iEWWOZ/QYGWEaBRW"
Content-Disposition: inline
In-Reply-To: <20181018075243.4798-3-aik@ozlabs.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Sam Bobroff <sbobroff@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--iEWWOZ/QYGWEaBRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 06:52:43PM +1100, Alexey Kardashevskiy wrote:
> The powernv platform registers IOMMU groups and adds devices to them
> from the pci_controller_ops::setup_bridge() hook except one case when
> virtual functions (SRIOV VFs) are added from a bus notifier.
>=20
> The pseries platform registers IOMMU groups from
> the pci_controller_ops::dma_bus_setup() hook and adds devices from
> the pci_controller_ops::dma_dev_setup() hook. The very same bus notifier
> used for powernv does not add devices for pseries though as
> __of_scan_bus() adds devices first, then it does the bus/dev DMA setup.
>=20
> Both platforms use iommu_add_device() which takes a device and expects
> it to have a valid IOMMU table struct with an iommu_table_group pointer
> which in turn points the iommu_group struct (which represents
> an IOMMU group). Although the helper seems easy to use, it relies on
> some pre-existing device configuration and associated data structures
> which it does not really need.
>=20
> This simplifies iommu_add_device() to take the table_group pointer
> directly. Pseries already has a table_group pointer handy and the bus
> notified is not used anyway. For powernv, this copies the existing bus
> notifier, makes it work for powernv only which means an easy way of
> getting to the table_group pointer. This was tested on VFs but should
> also support physical PCI hotplug.
>=20
> Since iommu_add_device() receives the table_group pointer directly,
> pseries does not do TCE cache invalidation (the hypervisor does) nor
> allow multiple groups per a VFIO container (in other words sharing
> an IOMMU table between partitionable endpoints), this removes
> iommu_table_group_link from pseries.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/include/asm/iommu.h          | 12 +++----
>  arch/powerpc/kernel/iommu.c               | 58 ++-----------------------=
------
>  arch/powerpc/platforms/powernv/pci-ioda.c | 10 +-----
>  arch/powerpc/platforms/powernv/pci.c      | 43 ++++++++++++++++++++++-
>  arch/powerpc/platforms/pseries/iommu.c    | 46 ++++++++++++------------
>  5 files changed, 74 insertions(+), 95 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/=
iommu.h
> index 726f07b..39bee10 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -220,9 +220,9 @@ struct iommu_table_group {
> =20
>  extern void iommu_register_group(struct iommu_table_group *table_group,
>  				 int pci_domain_number, unsigned long pe_num);
> -extern int iommu_add_device(struct device *dev);
> +extern int iommu_add_device(struct iommu_table_group *table_group,
> +		struct device *dev);
>  extern void iommu_del_device(struct device *dev);
> -extern int __init tce_iommu_bus_notifier_init(void);
>  extern long iommu_tce_xchg(struct mm_struct *mm, struct iommu_table *tbl,
>  		unsigned long entry, unsigned long *hpa,
>  		enum dma_data_direction *direction);
> @@ -233,7 +233,8 @@ static inline void iommu_register_group(struct iommu_=
table_group *table_group,
>  {
>  }
> =20
> -static inline int iommu_add_device(struct device *dev)
> +static inline int iommu_add_device(struct iommu_table_group *table_group,
> +		struct device *dev)
>  {
>  	return 0;
>  }
> @@ -241,11 +242,6 @@ static inline int iommu_add_device(struct device *de=
v)
>  static inline void iommu_del_device(struct device *dev)
>  {
>  }
> -
> -static inline int __init tce_iommu_bus_notifier_init(void)
> -{
> -        return 0;
> -}
>  #endif /* !CONFIG_IOMMU_API */
> =20
>  int dma_iommu_mapping_error(struct device *dev, dma_addr_t dma_addr);
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index 47d75c5..fb14fbf 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -1094,11 +1094,8 @@ void iommu_release_ownership(struct iommu_table *t=
bl)
>  }
>  EXPORT_SYMBOL_GPL(iommu_release_ownership);
> =20
> -int iommu_add_device(struct device *dev)
> +int iommu_add_device(struct iommu_table_group *table_group, struct devic=
e *dev)
>  {
> -	struct iommu_table *tbl;
> -	struct iommu_table_group_link *tgl;
> -
>  	/*
>  	 * The sysfs entries should be populated before
>  	 * binding IOMMU group. If sysfs entries isn't
> @@ -1114,32 +1111,10 @@ int iommu_add_device(struct device *dev)
>  		return -EBUSY;
>  	}
> =20
> -	tbl =3D get_iommu_table_base(dev);
> -	if (!tbl) {
> -		pr_debug("%s: Skipping device %s with no tbl\n",
> -			 __func__, dev_name(dev));
> -		return 0;
> -	}
> -
> -	tgl =3D list_first_entry_or_null(&tbl->it_group_list,
> -			struct iommu_table_group_link, next);
> -	if (!tgl) {
> -		pr_debug("%s: Skipping device %s with no group\n",
> -			 __func__, dev_name(dev));
> -		return 0;
> -	}
>  	pr_debug("%s: Adding %s to iommu group %d\n",
> -		 __func__, dev_name(dev),
> -		 iommu_group_id(tgl->table_group->group));
> +		 __func__, dev_name(dev),  iommu_group_id(table_group->group));
> =20
> -	if (PAGE_SIZE < IOMMU_PAGE_SIZE(tbl)) {
> -		pr_err("%s: Invalid IOMMU page size %lx (%lx) on %s\n",
> -		       __func__, IOMMU_PAGE_SIZE(tbl),
> -		       PAGE_SIZE, dev_name(dev));
> -		return -EINVAL;
> -	}
> -
> -	return iommu_group_add_device(tgl->table_group->group, dev);
> +	return iommu_group_add_device(table_group->group, dev);
>  }
>  EXPORT_SYMBOL_GPL(iommu_add_device);
> =20
> @@ -1159,31 +1134,4 @@ void iommu_del_device(struct device *dev)
>  	iommu_group_remove_device(dev);
>  }
>  EXPORT_SYMBOL_GPL(iommu_del_device);
> -
> -static int tce_iommu_bus_notifier(struct notifier_block *nb,
> -                unsigned long action, void *data)
> -{
> -        struct device *dev =3D data;
> -
> -        switch (action) {
> -        case BUS_NOTIFY_ADD_DEVICE:
> -                return iommu_add_device(dev);
> -        case BUS_NOTIFY_DEL_DEVICE:
> -                if (dev->iommu_group)
> -                        iommu_del_device(dev);
> -                return 0;
> -        default:
> -                return 0;
> -        }
> -}
> -
> -static struct notifier_block tce_iommu_bus_nb =3D {
> -        .notifier_call =3D tce_iommu_bus_notifier,
> -};
> -
> -int __init tce_iommu_bus_notifier_init(void)
> -{
> -        bus_register_notifier(&pci_bus_type, &tce_iommu_bus_nb);
> -        return 0;
> -}
>  #endif /* CONFIG_IOMMU_API */
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 4dc4a5fed..0228164 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1940,7 +1940,7 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_=
pe *pe,
>  		set_dma_offset(&dev->dev, pe->tce_bypass_base);
>  #ifdef CONFIG_IOMMU_API
>  		if (add_to_group)
> -			iommu_add_device(&dev->dev);
> +			iommu_add_device(&pe->table_group, &dev->dev);
>  #endif
> =20
>  		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
> @@ -2369,14 +2369,6 @@ static long pnv_pci_ioda2_setup_default_config(str=
uct pnv_ioda_pe *pe)
>  	if (!pnv_iommu_bypass_disabled)
>  		pnv_pci_ioda2_set_bypass(pe, true);
> =20
> -	/*
> -	 * Setting table base here only for carrying iommu_group
> -	 * further down to let iommu_add_device() do the job.
> -	 * pnv_pci_ioda_dma_dev_setup will override it later anyway.
> -	 */
> -	if (pe->flags & PNV_IODA_PE_DEV)
> -		set_iommu_table_base(&pe->pdev->dev, tbl);
> -
>  	return 0;
>  }
> =20
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platform=
s/powernv/pci.c
> index 13aef23..98e02c1 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -1127,4 +1127,45 @@ void __init pnv_pci_init(void)
>  	set_pci_dma_ops(&dma_iommu_ops);
>  }
> =20
> -machine_subsys_initcall_sync(powernv, tce_iommu_bus_notifier_init);
> +static int pnv_tce_iommu_bus_notifier(struct notifier_block *nb,
> +		unsigned long action, void *data)
> +{
> +	struct device *dev =3D data;
> +	struct pci_dev *pdev;
> +	struct pci_dn *pdn;
> +	struct pnv_ioda_pe *pe;
> +	struct pci_controller *hose;
> +	struct pnv_phb *phb;
> +
> +	switch (action) {
> +	case BUS_NOTIFY_ADD_DEVICE:
> +		pdev =3D to_pci_dev(dev);
> +		pdn =3D pci_get_pdn(pdev);
> +		hose =3D pci_bus_to_host(pdev->bus);
> +		phb =3D hose->private_data;
> +
> +		WARN_ON_ONCE(!phb);
> +		if (!pdn || pdn->pe_number =3D=3D IODA_INVALID_PE || !phb)
> +			return 0;
> +
> +		pe =3D &phb->ioda.pe_array[pdn->pe_number];
> +		iommu_add_device(&pe->table_group, dev);
> +		return 0;
> +	case BUS_NOTIFY_DEL_DEVICE:
> +		iommu_del_device(dev);
> +		return 0;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static struct notifier_block pnv_tce_iommu_bus_nb =3D {
> +	.notifier_call =3D pnv_tce_iommu_bus_notifier,
> +};
> +
> +static int __init pnv_tce_iommu_bus_notifier_init(void)
> +{
> +	bus_register_notifier(&pci_bus_type, &pnv_tce_iommu_bus_nb);
> +	return 0;
> +}
> +machine_subsys_initcall_sync(powernv, pnv_tce_iommu_bus_notifier_init);
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platfo=
rms/pseries/iommu.c
> index eae2578..38b6dd0 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -60,7 +60,6 @@ static struct iommu_table_group *iommu_pseries_alloc_gr=
oup(int node)
>  {
>  	struct iommu_table_group *table_group;
>  	struct iommu_table *tbl;
> -	struct iommu_table_group_link *tgl;
> =20
>  	table_group =3D kzalloc_node(sizeof(struct iommu_table_group), GFP_KERN=
EL,
>  			   node);
> @@ -71,22 +70,13 @@ static struct iommu_table_group *iommu_pseries_alloc_=
group(int node)
>  	if (!tbl)
>  		goto free_group;
> =20
> -	tgl =3D kzalloc_node(sizeof(struct iommu_table_group_link), GFP_KERNEL,
> -			node);
> -	if (!tgl)
> -		goto free_table;
> -
>  	INIT_LIST_HEAD_RCU(&tbl->it_group_list);
>  	kref_init(&tbl->it_kref);
> -	tgl->table_group =3D table_group;
> -	list_add_rcu(&tgl->next, &tbl->it_group_list);
> =20
>  	table_group->tables[0] =3D tbl;
> =20
>  	return table_group;
> =20
> -free_table:
> -	kfree(tbl);
>  free_group:
>  	kfree(table_group);
>  	return NULL;
> @@ -96,23 +86,12 @@ static void iommu_pseries_free_group(struct iommu_tab=
le_group *table_group,
>  		const char *node_name)
>  {
>  	struct iommu_table *tbl;
> -#ifdef CONFIG_IOMMU_API
> -	struct iommu_table_group_link *tgl;
> -#endif
> =20
>  	if (!table_group)
>  		return;
> =20
>  	tbl =3D table_group->tables[0];
>  #ifdef CONFIG_IOMMU_API
> -	tgl =3D list_first_entry_or_null(&tbl->it_group_list,
> -			struct iommu_table_group_link, next);
> -
> -	WARN_ON_ONCE(!tgl);
> -	if (tgl) {
> -		list_del_rcu(&tgl->next);
> -		kfree(tgl);
> -	}
>  	if (table_group->group) {
>  		iommu_group_put(table_group->group);
>  		BUG_ON(table_group->group);
> @@ -1240,7 +1219,7 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_=
dev *dev)
>  	}
> =20
>  	set_iommu_table_base(&dev->dev, pci->table_group->tables[0]);
> -	iommu_add_device(&dev->dev);
> +	iommu_add_device(pci->table_group, &dev->dev);
>  }
> =20
>  static int dma_set_mask_pSeriesLP(struct device *dev, u64 dma_mask)
> @@ -1455,4 +1434,27 @@ static int __init disable_multitce(char *str)
> =20
>  __setup("multitce=3D", disable_multitce);
> =20
> +static int tce_iommu_bus_notifier(struct notifier_block *nb,
> +		unsigned long action, void *data)
> +{
> +	struct device *dev =3D data;
> +
> +	switch (action) {
> +	case BUS_NOTIFY_DEL_DEVICE:
> +		iommu_del_device(dev);
> +		return 0;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static struct notifier_block tce_iommu_bus_nb =3D {
> +	.notifier_call =3D tce_iommu_bus_notifier,
> +};
> +
> +static int __init tce_iommu_bus_notifier_init(void)
> +{
> +	bus_register_notifier(&pci_bus_type, &tce_iommu_bus_nb);
> +	return 0;
> +}
>  machine_subsys_initcall_sync(pseries, tce_iommu_bus_notifier_init);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--iEWWOZ/QYGWEaBRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvjxxoACgkQbDjKyiDZ
s5IucRAAxDKReL4Ay2/BuWVg9n5XAWp3Xz1ycioK8XBQoCf9t37CEzxIQEZ7nw68
HNH3Phvro+VSvLGbaHHpxLzv7yVBgYadMas4eoMhcPwSKJs/MSYYhkfF3dlPX4ST
zpwedMSwL/Evord1hKRf4gG99zdRx8CxEqIsRgTFwZIa5NemLWWsUEj5on+Mc2yR
Dw1TG8eDZTT9VnKdR2fubhqCqGtAWhE5BCPtSyHiipQUM+91lSUgfw6CXoEP7m5/
Xl0Glp9LFPTY7TpH+xuByflIQg6KVSgMf8vYVW3cjo3WcboLKKyO9rrsnVsJZD4Z
ri319DGQX0t9Sic/+edTWqb6kkCkK0ibh5cEekREkwmgcIa8cmw2o/XQlJhy0wJ0
DBeDEp05A0c9/Z5pyM7kDsCFNH/5lpmvCJpv7qX3L7osdgX+AIsbELdVsMcyyyp0
E9MI6QHo3Sy/B+leSzn6xG5lvgjraUk0SK4t4IAiucWslEYQmLlOcm80UsB1zoNP
tNElJZFDw8vLHo16pJEebrS0H5beBNr61R2/5UhMoQr3dhUZQx/P8iN2WuvKvm1n
5S8H1QZSYH1J2AqwNj+E6t/Miqujw0qTSzNmTAM863hwx4GIaNCkC269F5OgJMh3
gesnuy0nMED5wUptCrHx2LYkFELOAe+Ibdcc/uI0NVrNKhxWi3w=
=16rt
-----END PGP SIGNATURE-----

--iEWWOZ/QYGWEaBRW--
