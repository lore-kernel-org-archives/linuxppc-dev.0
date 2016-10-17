Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sy74v0ZyCzDvHv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Oct 2016 17:06:35 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id s8so12068582pfj.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Oct 2016 23:06:35 -0700 (PDT)
Subject: Re: [PATCH kernel 14/15] vfio/spapr_tce: Export container API for
 external users
To: David Gibson <david@gibson.dropbear.id.au>
References: <4d1ea52b-ecb5-5f9b-6cdc-00a73677cc2f@ozlabs.ru>
 <20160810104630.21ab4bc5@t450s.home> <20160812054601.GS16493@voom.fritz.box>
 <20160812092201.243f4e15@t450s.home> <20160817031725.GM14530@voom.fritz.box>
 <2273cf1c-babb-fbe1-c1e4-487291b9910a@ozlabs.ru>
 <f339c165-d24a-76e4-b3cd-b3d73e325421@ozlabs.ru>
 <20160829132722.GB2166@littlecatz>
 <ea9928c6-39a2-2ddc-7d1e-54329b2c506c@ozlabs.ru>
 <b6e19d96-c783-3359-c5bb-26d2069c155b@ozlabs.ru>
 <20160923071208.GB2085@umbus.fritz.box>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <4274dd93-3911-3fa3-7d96-b985f031f547@ozlabs.ru>
Date: Mon, 17 Oct 2016 17:06:28 +1100
MIME-Version: 1.0
In-Reply-To: <20160923071208.GB2085@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="stXUlksjxHEl5FclBEpo1wCfEgdfnSXwC"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--stXUlksjxHEl5FclBEpo1wCfEgdfnSXwC
Content-Type: multipart/mixed; boundary="4N2VArfWlvAHimxoG34NUfbnwKGOMMgf9";
 protected-headers="v1"
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
Message-ID: <4274dd93-3911-3fa3-7d96-b985f031f547@ozlabs.ru>
Subject: Re: [PATCH kernel 14/15] vfio/spapr_tce: Export container API for
 external users
References: <4d1ea52b-ecb5-5f9b-6cdc-00a73677cc2f@ozlabs.ru>
 <20160810104630.21ab4bc5@t450s.home> <20160812054601.GS16493@voom.fritz.box>
 <20160812092201.243f4e15@t450s.home> <20160817031725.GM14530@voom.fritz.box>
 <2273cf1c-babb-fbe1-c1e4-487291b9910a@ozlabs.ru>
 <f339c165-d24a-76e4-b3cd-b3d73e325421@ozlabs.ru>
 <20160829132722.GB2166@littlecatz>
 <ea9928c6-39a2-2ddc-7d1e-54329b2c506c@ozlabs.ru>
 <b6e19d96-c783-3359-c5bb-26d2069c155b@ozlabs.ru>
 <20160923071208.GB2085@umbus.fritz.box>
In-Reply-To: <20160923071208.GB2085@umbus.fritz.box>

--4N2VArfWlvAHimxoG34NUfbnwKGOMMgf9
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

So far I got one question, below.


On 23/09/16 17:12, David Gibson wrote:
> On Wed, Sep 21, 2016 at 04:56:52PM +1000, Alexey Kardashevskiy wrote:
>> On 07/09/16 19:09, Alexey Kardashevskiy wrote:
>>> On 29/08/16 23:27, David Gibson wrote:
>>>> On Mon, Aug 29, 2016 at 04:35:15PM +1000, Alexey Kardashevskiy wrote=
:
>>>>> On 18/08/16 10:22, Alexey Kardashevskiy wrote:
>>>>>> On 17/08/16 13:17, David Gibson wrote:
>>>>>>> On Fri, Aug 12, 2016 at 09:22:01AM -0600, Alex Williamson wrote:
>>>>>>>> On Fri, 12 Aug 2016 15:46:01 +1000
>>>>>>>> David Gibson <david@gibson.dropbear.id.au> wrote:
>>>>>>>>
>>>>>>>>> On Wed, Aug 10, 2016 at 10:46:30AM -0600, Alex Williamson wrote=
:
>>>>>>>>>> On Wed, 10 Aug 2016 15:37:17 +1000
>>>>>>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>>>>>>>>  =20
>>>>>>>>>>> On 09/08/16 22:16, Alex Williamson wrote: =20
>>>>>>>>>>>> On Tue, 9 Aug 2016 15:19:39 +1000
>>>>>>>>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>>>>>>>>>>    =20
>>>>>>>>>>>>> On 09/08/16 02:43, Alex Williamson wrote:   =20
>>>>>>>>>>>>>> On Wed,  3 Aug 2016 18:40:55 +1000
>>>>>>>>>>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>>>>>>>>>>>>      =20
>>>>>>>>>>>>>>> This exports helpers which are needed to keep a VFIO cont=
ainer in
>>>>>>>>>>>>>>> memory while there are external users such as KVM.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>  drivers/vfio/vfio.c                 | 30 +++++++++++++++=
+++++++++++++++
>>>>>>>>>>>>>>>  drivers/vfio/vfio_iommu_spapr_tce.c | 16 +++++++++++++++=
-
>>>>>>>>>>>>>>>  include/linux/vfio.h                |  6 ++++++
>>>>>>>>>>>>>>>  3 files changed, 51 insertions(+), 1 deletion(-)
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
>>>>>>>>>>>>>>> index d1d70e0..baf6a9c 100644
>>>>>>>>>>>>>>> --- a/drivers/vfio/vfio.c
>>>>>>>>>>>>>>> +++ b/drivers/vfio/vfio.c
>>>>>>>>>>>>>>> @@ -1729,6 +1729,36 @@ long vfio_external_check_extension=
(struct vfio_group *group, unsigned long arg)
>>>>>>>>>>>>>>>  EXPORT_SYMBOL_GPL(vfio_external_check_extension);
>>>>>>>>>>>>>>> =20
>>>>>>>>>>>>>>>  /**
>>>>>>>>>>>>>>> + * External user API for containers, exported by symbols=
 to be linked
>>>>>>>>>>>>>>> + * dynamically.
>>>>>>>>>>>>>>> + *
>>>>>>>>>>>>>>> + */
>>>>>>>>>>>>>>> +struct vfio_container *vfio_container_get_ext(struct fil=
e *filep)
>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>> +	struct vfio_container *container =3D filep->private_dat=
a;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +	if (filep->f_op !=3D &vfio_fops)
>>>>>>>>>>>>>>> +		return ERR_PTR(-EINVAL);
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +	vfio_container_get(container);
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +	return container;
>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>> +EXPORT_SYMBOL_GPL(vfio_container_get_ext);
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +void vfio_container_put_ext(struct vfio_container *conta=
iner)
>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>> +	vfio_container_put(container);
>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>> +EXPORT_SYMBOL_GPL(vfio_container_put_ext);
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +void *vfio_container_get_iommu_data_ext(struct vfio_cont=
ainer *container)
>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>> +	return container->iommu_data;
>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>> +EXPORT_SYMBOL_GPL(vfio_container_get_iommu_data_ext);
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +/**
>>>>>>>>>>>>>>>   * Sub-module support
>>>>>>>>>>>>>>>   */
>>>>>>>>>>>>>>>  /*
>>>>>>>>>>>>>>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/driver=
s/vfio/vfio_iommu_spapr_tce.c
>>>>>>>>>>>>>>> index 3594ad3..fceea3d 100644
>>>>>>>>>>>>>>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
>>>>>>>>>>>>>>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>>>>>>>>>>>>>>> @@ -1331,6 +1331,21 @@ const struct vfio_iommu_driver_ops=
 tce_iommu_driver_ops =3D {
>>>>>>>>>>>>>>>  	.detach_group	=3D tce_iommu_detach_group,
>>>>>>>>>>>>>>>  };
>>>>>>>>>>>>>>> =20
>>>>>>>>>>>>>>> +struct iommu_table *vfio_container_spapr_tce_table_get_e=
xt(void *iommu_data,
>>>>>>>>>>>>>>> +		u64 offset)
>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>> +	struct tce_container *container =3D iommu_data;
>>>>>>>>>>>>>>> +	struct iommu_table *tbl =3D NULL;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +	if (tce_iommu_find_table(container, offset, &tbl) < 0)
>>>>>>>>>>>>>>> +		return NULL;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +	iommu_table_get(tbl);
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +	return tbl;
>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>> +EXPORT_SYMBOL_GPL(vfio_container_spapr_tce_table_get_ext=
);
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>  static int __init tce_iommu_init(void)
>>>>>>>>>>>>>>>  {
>>>>>>>>>>>>>>>  	return vfio_register_iommu_driver(&tce_iommu_driver_ops=
);
>>>>>>>>>>>>>>> @@ -1348,4 +1363,3 @@ MODULE_VERSION(DRIVER_VERSION);
>>>>>>>>>>>>>>>  MODULE_LICENSE("GPL v2");
>>>>>>>>>>>>>>>  MODULE_AUTHOR(DRIVER_AUTHOR);
>>>>>>>>>>>>>>>  MODULE_DESCRIPTION(DRIVER_DESC);
>>>>>>>>>>>>>>> -
>>>>>>>>>>>>>>> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
>>>>>>>>>>>>>>> index 0ecae0b..1c2138a 100644
>>>>>>>>>>>>>>> --- a/include/linux/vfio.h
>>>>>>>>>>>>>>> +++ b/include/linux/vfio.h
>>>>>>>>>>>>>>> @@ -91,6 +91,12 @@ extern void vfio_group_put_external_us=
er(struct vfio_group *group);
>>>>>>>>>>>>>>>  extern int vfio_external_user_iommu_id(struct vfio_group=
 *group);
>>>>>>>>>>>>>>>  extern long vfio_external_check_extension(struct vfio_gr=
oup *group,
>>>>>>>>>>>>>>>  					  unsigned long arg);
>>>>>>>>>>>>>>> +extern struct vfio_container *vfio_container_get_ext(str=
uct file *filep);
>>>>>>>>>>>>>>> +extern void vfio_container_put_ext(struct vfio_container=
 *container);
>>>>>>>>>>>>>>> +extern void *vfio_container_get_iommu_data_ext(
>>>>>>>>>>>>>>> +		struct vfio_container *container);
>>>>>>>>>>>>>>> +extern struct iommu_table *vfio_container_spapr_tce_tabl=
e_get_ext(
>>>>>>>>>>>>>>> +		void *iommu_data, u64 offset);
>>>>>>>>>>>>>>> =20
>>>>>>>>>>>>>>>  /*
>>>>>>>>>>>>>>>   * Sub-module helpers     =20
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I think you need to take a closer look of the lifecycle of=
 a container,
>>>>>>>>>>>>>> having a reference means the container itself won't go awa=
y, but only
>>>>>>>>>>>>>> having a group set within that container holds the actual =
IOMMU
>>>>>>>>>>>>>> references.  container->iommu_data is going to be NULL onc=
e the
>>>>>>>>>>>>>> groups are lost.  Thanks,     =20
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Container owns the iommu tables and this is what I care abo=
ut here, groups
>>>>>>>>>>>>> attached or not - this is handled separately via IOMMU grou=
p list in a
>>>>>>>>>>>>> specific iommu_table struct, these groups get detached from=
 iommu_table
>>>>>>>>>>>>> when they are removed from a container.   =20
>>>>>>>>>>>>
>>>>>>>>>>>> The container doesn't own anything, the container is privile=
ged by the
>>>>>>>>>>>> groups being attached to it.  When groups are closed, they d=
etach from
>>>>>>>>>>>> the container and once the container group list is empty the=
 iommu
>>>>>>>>>>>> backend is released and iommu_data is NULL.  A container ref=
erence
>>>>>>>>>>>> doesn't give you what you're looking for.  It implies nothin=
g about the
>>>>>>>>>>>> iommu backend.   =20
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Well. Backend is a part of a container and since a backend ow=
ns tables, a
>>>>>>>>>>> container owns them too. =20
>>>>>>>>>>
>>>>>>>>>> The IOMMU backend is accessed through the container, but that =
backend
>>>>>>>>>> is privileged by the groups it contains.  Once those groups ar=
e gone,
>>>>>>>>>> the IOMMU backend is released, regardless of whatever referenc=
e you
>>>>>>>>>> have to the container itself such as you're attempting to do h=
ere.  In
>>>>>>>>>> that sense, the container does not own those tables. =20
>>>>>>>>>
>>>>>>>>> So, the thing is that what KVM fundamentally needs is a handle =
on the
>>>>>>>>> container.  KVM is essentially modelling the DMA address space =
of a
>>>>>>>>> single guest bus, and the container is what's attached to that.=

>>>>>>>>>
>>>>>>>>> The first part of the problem is that KVM wants to basically in=
voke
>>>>>>>>> vfio_dma_map() operations without bouncing via qemu.  Because
>>>>>>>>> vfio_dma_map() works on the container level, that's the handle =
that
>>>>>>>>> KVM needs to hold.
>>>>>>>>>
>>>>>>>>> The second part of the problem is that in order to reduce overh=
ead
>>>>>>>>> further, we want to operate in real mode, which means bypassing=
 most
>>>>>>>>> of the usual VFIO structure and going directly(ish) from the KV=
M
>>>>>>>>> hcall emulation to the IOMMU backend behind VFIO.  This complic=
ates
>>>>>>>>> matters a fair bit.  Because it is, explicitly, a performance h=
ack,
>>>>>>>>> some degree of ugliness is probably inevitable.
>>>>>>>>>
>>>>>>>>> Alexey - actually implementing this in two stages might make th=
is
>>>>>>>>> clearer.  The first stage wouldn't allow real mode, and would c=
all
>>>>>>>>> through the same vfio_dma_map() path as qemu calls through now.=
  The
>>>>>>>>> second stage would then put in place the necessary hacks to add=
 real
>>>>>>>>> mode support.
>>>>>>>>>
>>>>>>>>>>> The problem I am trying to solve here is when KVM may release=
 the
>>>>>>>>>>> iommu_table objects.
>>>>>>>>>>>
>>>>>>>>>>> "Set" ioctl() to KVM-spapr-tce-table (or KVM itself, does not=
 really
>>>>>>>>>>> matter) makes a link between KVM-spapr-tce-table and containe=
r and KVM can
>>>>>>>>>>> start using tables (with referencing them).
>>>>>>>>>>>
>>>>>>>>>>> First I tried adding an "unset" ioctl to KVM-spapr-tce-table,=
 called it
>>>>>>>>>>> from region_del() and this works if QEMU removes a window. Ho=
wever if QEMU
>>>>>>>>>>> removes a vfio-pci device, region_del() is not called and KVM=
 does not get
>>>>>>>>>>> notified that it can release the iommu_table's because the
>>>>>>>>>>> KVM-spapr-tce-table remains alive and does not get destroyed =
(as it is
>>>>>>>>>>> still used by emulated devices or other containers).
>>>>>>>>>>>
>>>>>>>>>>> So it was suggested that we could do such "unset" somehow lat=
er assuming,
>>>>>>>>>>> for example, on every "set" I could check if some of currentl=
y attached
>>>>>>>>>>> containers are no more used - and this is where being able to=
 know if there
>>>>>>>>>>> is no backend helps - KVM remembers a container pointer and c=
an check this
>>>>>>>>>>> via vfio_container_get_iommu_data_ext().
>>>>>>>>>>>
>>>>>>>>>>> The other option would be changing vfio_container_get_ext() t=
o take a
>>>>>>>>>>> callback+opaque which container would call when it destroys i=
ommu_data.
>>>>>>>>>>> This looks more intrusive and not very intuitive how to make =
it right -
>>>>>>>>>>> container would have to keep track of all registered external=
 users and
>>>>>>>>>>> vfio_container_put_ext() would have to pass the same callback=
+opaque to
>>>>>>>>>>> unregister the exact external user. =20
>>>>>>>>>>
>>>>>>>>>> I'm not in favor of anything resembling the code above or exte=
nsions
>>>>>>>>>> beyond it, the container is the wrong place to do this.
>>>>>>>>>>  =20
>>>>>>>>>>> Or I could store container file* in KVM. Then iommu_data woul=
d never be
>>>>>>>>>>> released until KVM-spapr-tce-table is destroyed. =20
>>>>>>>>>>
>>>>>>>>>> See above, holding a file pointer to the container doesn't do =
squat.
>>>>>>>>>> The groups that are held by the container empower the IOMMU ba=
ckend,
>>>>>>>>>> references to the container itself don't matter.  Those refere=
nces will
>>>>>>>>>> not maintain the IOMMU data.
>>>>>>>>>>   =20
>>>>>>>>>>> Recreating KVM-spapr-tce-table on every vfio-pci hotunplug (c=
losing its fd
>>>>>>>>>>> would "unset" container from KVM-spapr-tce-table) is not an o=
ption as there
>>>>>>>>>>> still may be devices using this KVM-spapr-tce-table.
>>>>>>>>>>>
>>>>>>>>>>> What obvious and nice solution am I missing here? Thanks. =20
>>>>>>>>>>
>>>>>>>>>> The interactions with the IOMMU backend that seem relevant are=

>>>>>>>>>> vfio_iommu_drivers_ops.{detach_group,release}.  The kvm-vfio p=
seudo
>>>>>>>>>> device is also used to tell kvm about groups as they come and =
go and
>>>>>>>>>> has a way to check extensions, and thus properties of the IOMM=
U
>>>>>>>>>> backend.  All of these are available for your {ab}use.  Thanks=
, =20
>>>>>>>>>
>>>>>>>>> So, Alexey started trying to do this via the KVM-VFIO device, b=
ut it's
>>>>>>>>> a really bad fit.  As noted above, fundamentally it's a contain=
er we
>>>>>>>>> need to attach to the kvm-spapr-tce-table object, since what th=
at
>>>>>>>>> represents is a guest bus DMA address space, and by definition =
all the
>>>>>>>>> groups in a container must have the same DMA address space.
>>>>>>>>
>>>>>>>> That's all fine and good, but the point remains that a reference=
 to the
>>>>>>>> container is no assurance of the iommu state.  The iommu state i=
s
>>>>>>>> maintained by the user and the groups attached to the container.=
  If
>>>>>>>> the groups are removed, your container reference no long has any=
 iommu
>>>>>>>> backing and iommu_data is worthless.  The user can do this as we=
ll by
>>>>>>>> un-setting the iommu.  I understand what you're trying to do, it=
's just
>>>>>>>> wrong.  Thanks,
>>>>>>>
>>>>>>> I'm trying to figure out how to do this right, and it's not at al=
l
>>>>>>> obvious.  The container may be wrong, but that doesn't have the
>>>>>>> KVM-VFIO device any more useful.  Attempting to do this at the gr=
oup
>>>>>>> level is at least as wrong for the reasons I've mentioned elsewhe=
re.
>>>>>>>
>>>>>>
>>>>>> I could create a new fd, one per iommu_table, the fd would referen=
ce the
>>>>>> iommu_table (not touching an iommu_table_group or a container), VF=
IO SPAPR
>>>>>> TCE backend would return it in VFIO_IOMMU_SPAPR_TCE_CREATE (ioctl =
which
>>>>>> creates windows) or I could add VFIO_IOMMU_SPAPR_TCE_GET_FD_BY_OFF=
SET; then
>>>>>> I'd pass this new fd to the KVM or KVM-spapr-tce-table to hook the=
m up. To
>>>>>> release the reference, KVM-spapr-tce-table would have "unset" ioct=
l()
>>>>>> or/and on every "set" I would look if all attached tables have at =
least one
>>>>>> iommu_table_group attached, if none - release the table.
>>>>>>
>>>>>> This would make no change to generic VFIO code and very little cha=
nge in
>>>>>> SPAPR TCE backend. Would that be acceptable or it is horrible agai=
n? Thanks.
>>>>>
>>>>>
>>>>> Ping?
>>>>
>>>> I'm still in Toronto after KVM Forum.  I had a detailed discussion
>>>> about this with Alex W, which I'll write up once I get back.
>>>>
>>>> The short version is that Alex more-or-less convinced me that we do
>>>> need to go back to doing this with an interface based on linking
>>>> groups to LIOBNs.  That leads to an interface that's kind of weird a=
nd
>>>> has some fairly counter-intuitive properties, but in the end it work=
s
>>>> out better than doing it with containers.
>>>>
>>>
>>>
>>>
>>>
>>> Soooo? :)
>>
>>
>> When can I expect a full version of how to do this in-kernel thingy?
>> Thanks.
>=20
> When I can dig myself out from under other things in my queue.  Which
> turns out to be now.
>=20
> Ok.. here's hoping I can remember enough of the conclusions I came to
> with Alex W.
>=20
> User <-> KVM interface
> ----------------------
>=20
> This needs to take an LIOBN and a group fd and associate (or
> disassociate) them.  This should be possible to do by adding each
> group to the vfio-kvm device as on x86, then setting an attribute on
> the device to mark the associated liobn.
>=20
> Attaching different (overlapping) LIOBNs to different groups in the
> same container is boundedly undefined (i.e. it mustn't break the host,
> but can do anything to the guest).
>=20
> KVM <-> VFIO (in kernel) interface
> ----------------------------------
>=20
> You'll need a special function which takes a vfio group fd and returns
> a reference to an iommu_table object.  It would also return an error
> if the group isn't backed by the spapr_tce iommu driver (including any
> calls to it on a non-ppc host).  This should probably also increment
> the iommu table's ref count (on success).
>=20
> Implementation notes
> --------------------
>=20
> When a device in a new group is hotplugged, qemu would need to add the
> group to the container *then* tell KVM to attach the group to the
> correct liobn(s).
>=20
> KVM would add the group to a list for that liobn.  It would call the
> vfio hook to get the associated iommu table.  If there's an error,
> then it's unable to enable acceleration, and would either return an
> error immediately or ensure that later attempts to PUT_TCE will be
> punted to qemu.
>=20
> Assuming it is able to accelerate, it would add the iommu table to a
> list of iommu tables associated with the liobn.  It will need to
> de-dupe here, since with multiple groups per container you'd expect
> multiple groups with the same iommu table.
>=20
> H_PUT_TCE would walk the list of attached iommu tables and update them
> using the ppc kernel iommu interfaces.
>=20
> When a group is removed from a liobn, kvm would need to recalculate
> the list of iommu tables, in case that was the last group attached to
> the table.  It would need to decrement the refcount on the iommu table
> and, obviously, make sure everything is sychronized with the real mode
> PUT_TCE.
>=20
> When a group is hot unplugged, it's qemu's resposibility to tell kvm
> that the group is no longer associated with the liobn, before it
> removes the group from the container.=20


Cannot VFIO KVM device just release this extra reference when QEMU calls
KVM_DEV_VFIO_GROUP_DEL from  vfio_instance_finalize->vfio_put_group?



> If it doesn't there may be a
> stale iommu table attached to the liobn.  That could certainly mess up
> DMA on the guest for other devices, but shouldn't damage the host -
> the group now belongs to the host again, but because the group was
> detached from the container, the HW is no longer using the container's
> iommu table (which KVM is touching) to actually serve the group.
>=20
> If all the groups are unplugged, so the container becomes quiescent,
> KVM's refcount(s) on the iommu table stop it going away.  It won't be
> looked at by the hardware any more, so updates will be useless, but
> again that's only a problem for the guest, not the host.
>=20
>=20
> Hope that covers it.
>=20
> Alex, please let me know if I missed something from our discussion.
>=20


--=20
Alexey


--4N2VArfWlvAHimxoG34NUfbnwKGOMMgf9--

--stXUlksjxHEl5FclBEpo1wCfEgdfnSXwC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYBGpkAAoJEIYTPdgrwSC5SDIP/R3iJTSIfHDcRaCIktjHaL8F
KlrT1S7+PjickrTRQRHM7fJdlOsTxeSQpyoCiH1NRe8J5NI2grt1EDT+SH2IWmx+
BrvodaiHMB4ZysfI/aHjpCcSoJQDUU5I28dEEoeljCeU3XBEMxGacZ8EoPtf0M9P
UcWzPJRN6wDKKt2uJo4WcClNRvktxkMwJVqUNDPCvGEwzXCKCFDacJb416cQa4/8
t0ZFhAZIaU24my6DvQAgIMy/aJB5JmGAn0CAge0EftfhNe5+wq5fhIEc/7qVA1m2
wN5o55nPLV92/dUfRwKnwJ/gDu3uPGwOBFN+Obmf64QBZ8u62+G7FW2WtQkuhl5j
3exW9LmzoXF3RcXTDxYiine8Xk2QAy+d282LNlwjKSI0Zvyce+Z7TVCizoUtW/8S
8BlbLwV5FkBqoCwhpZx2Nv/9C1fIEwMyZaqfPnCBtHQ3F3V4ggpq7zlTUBmy6EqS
OvtoIb44Q56wziVEnxMv67ErPNWUJybW1BjsigsrZmGJx5NBglXuDNHkcWdHzWj6
/gWstAOQcnuna1+D4Hgv6foO5BRDCOcQlmH3XVjfTiT9hInIklsrrWUeP3vRFcW6
VJXx9ukJGwyQiQAbUOtUQQ5E113hFHpuRxntd4j7n6tewTA8BBSCDz7GzvgQvLFB
FCoysA+/et/oZDUoh5+c
=zN9n
-----END PGP SIGNATURE-----

--stXUlksjxHEl5FclBEpo1wCfEgdfnSXwC--
