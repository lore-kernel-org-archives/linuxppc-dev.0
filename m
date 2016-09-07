Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sTd3126qLzDrvP
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Sep 2016 19:10:03 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id pp5so612956pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Sep 2016 02:10:03 -0700 (PDT)
Subject: Re: [PATCH kernel 14/15] vfio/spapr_tce: Export container API for
 external users
To: David Gibson <david@gibson.dropbear.id.au>
References: <20160808104315.77cf22ec@t450s.home>
 <f338a1d3-438a-9004-9645-87a16b9baf79@ozlabs.ru>
 <20160809061630.50ed5536@t450s.home>
 <4d1ea52b-ecb5-5f9b-6cdc-00a73677cc2f@ozlabs.ru>
 <20160810104630.21ab4bc5@t450s.home> <20160812054601.GS16493@voom.fritz.box>
 <20160812092201.243f4e15@t450s.home> <20160817031725.GM14530@voom.fritz.box>
 <2273cf1c-babb-fbe1-c1e4-487291b9910a@ozlabs.ru>
 <f339c165-d24a-76e4-b3cd-b3d73e325421@ozlabs.ru>
 <20160829132722.GB2166@littlecatz>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <ea9928c6-39a2-2ddc-7d1e-54329b2c506c@ozlabs.ru>
Date: Wed, 7 Sep 2016 19:09:55 +1000
MIME-Version: 1.0
In-Reply-To: <20160829132722.GB2166@littlecatz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uVKcb3I4egwwtgOEdTirGQHbcFGR3aaNk"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uVKcb3I4egwwtgOEdTirGQHbcFGR3aaNk
Content-Type: multipart/mixed; boundary="5TFTSKpIjlbM3iL7ELFHKIGQjxd5lnCL9";
 protected-headers="v1"
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
Message-ID: <ea9928c6-39a2-2ddc-7d1e-54329b2c506c@ozlabs.ru>
Subject: Re: [PATCH kernel 14/15] vfio/spapr_tce: Export container API for
 external users
References: <20160808104315.77cf22ec@t450s.home>
 <f338a1d3-438a-9004-9645-87a16b9baf79@ozlabs.ru>
 <20160809061630.50ed5536@t450s.home>
 <4d1ea52b-ecb5-5f9b-6cdc-00a73677cc2f@ozlabs.ru>
 <20160810104630.21ab4bc5@t450s.home> <20160812054601.GS16493@voom.fritz.box>
 <20160812092201.243f4e15@t450s.home> <20160817031725.GM14530@voom.fritz.box>
 <2273cf1c-babb-fbe1-c1e4-487291b9910a@ozlabs.ru>
 <f339c165-d24a-76e4-b3cd-b3d73e325421@ozlabs.ru>
 <20160829132722.GB2166@littlecatz>
In-Reply-To: <20160829132722.GB2166@littlecatz>

--5TFTSKpIjlbM3iL7ELFHKIGQjxd5lnCL9
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 29/08/16 23:27, David Gibson wrote:
> On Mon, Aug 29, 2016 at 04:35:15PM +1000, Alexey Kardashevskiy wrote:
>> On 18/08/16 10:22, Alexey Kardashevskiy wrote:
>>> On 17/08/16 13:17, David Gibson wrote:
>>>> On Fri, Aug 12, 2016 at 09:22:01AM -0600, Alex Williamson wrote:
>>>>> On Fri, 12 Aug 2016 15:46:01 +1000
>>>>> David Gibson <david@gibson.dropbear.id.au> wrote:
>>>>>
>>>>>> On Wed, Aug 10, 2016 at 10:46:30AM -0600, Alex Williamson wrote:
>>>>>>> On Wed, 10 Aug 2016 15:37:17 +1000
>>>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>>>>>  =20
>>>>>>>> On 09/08/16 22:16, Alex Williamson wrote: =20
>>>>>>>>> On Tue, 9 Aug 2016 15:19:39 +1000
>>>>>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>>>>>>>    =20
>>>>>>>>>> On 09/08/16 02:43, Alex Williamson wrote:   =20
>>>>>>>>>>> On Wed,  3 Aug 2016 18:40:55 +1000
>>>>>>>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>>>>>>>>>      =20
>>>>>>>>>>>> This exports helpers which are needed to keep a VFIO contain=
er in
>>>>>>>>>>>> memory while there are external users such as KVM.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>>>>>>>>>> ---
>>>>>>>>>>>>  drivers/vfio/vfio.c                 | 30 ++++++++++++++++++=
++++++++++++
>>>>>>>>>>>>  drivers/vfio/vfio_iommu_spapr_tce.c | 16 +++++++++++++++-
>>>>>>>>>>>>  include/linux/vfio.h                |  6 ++++++
>>>>>>>>>>>>  3 files changed, 51 insertions(+), 1 deletion(-)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
>>>>>>>>>>>> index d1d70e0..baf6a9c 100644
>>>>>>>>>>>> --- a/drivers/vfio/vfio.c
>>>>>>>>>>>> +++ b/drivers/vfio/vfio.c
>>>>>>>>>>>> @@ -1729,6 +1729,36 @@ long vfio_external_check_extension(st=
ruct vfio_group *group, unsigned long arg)
>>>>>>>>>>>>  EXPORT_SYMBOL_GPL(vfio_external_check_extension);
>>>>>>>>>>>> =20
>>>>>>>>>>>>  /**
>>>>>>>>>>>> + * External user API for containers, exported by symbols to=
 be linked
>>>>>>>>>>>> + * dynamically.
>>>>>>>>>>>> + *
>>>>>>>>>>>> + */
>>>>>>>>>>>> +struct vfio_container *vfio_container_get_ext(struct file *=
filep)
>>>>>>>>>>>> +{
>>>>>>>>>>>> +	struct vfio_container *container =3D filep->private_data;
>>>>>>>>>>>> +
>>>>>>>>>>>> +	if (filep->f_op !=3D &vfio_fops)
>>>>>>>>>>>> +		return ERR_PTR(-EINVAL);
>>>>>>>>>>>> +
>>>>>>>>>>>> +	vfio_container_get(container);
>>>>>>>>>>>> +
>>>>>>>>>>>> +	return container;
>>>>>>>>>>>> +}
>>>>>>>>>>>> +EXPORT_SYMBOL_GPL(vfio_container_get_ext);
>>>>>>>>>>>> +
>>>>>>>>>>>> +void vfio_container_put_ext(struct vfio_container *containe=
r)
>>>>>>>>>>>> +{
>>>>>>>>>>>> +	vfio_container_put(container);
>>>>>>>>>>>> +}
>>>>>>>>>>>> +EXPORT_SYMBOL_GPL(vfio_container_put_ext);
>>>>>>>>>>>> +
>>>>>>>>>>>> +void *vfio_container_get_iommu_data_ext(struct vfio_contain=
er *container)
>>>>>>>>>>>> +{
>>>>>>>>>>>> +	return container->iommu_data;
>>>>>>>>>>>> +}
>>>>>>>>>>>> +EXPORT_SYMBOL_GPL(vfio_container_get_iommu_data_ext);
>>>>>>>>>>>> +
>>>>>>>>>>>> +/**
>>>>>>>>>>>>   * Sub-module support
>>>>>>>>>>>>   */
>>>>>>>>>>>>  /*
>>>>>>>>>>>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/v=
fio/vfio_iommu_spapr_tce.c
>>>>>>>>>>>> index 3594ad3..fceea3d 100644
>>>>>>>>>>>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
>>>>>>>>>>>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>>>>>>>>>>>> @@ -1331,6 +1331,21 @@ const struct vfio_iommu_driver_ops tc=
e_iommu_driver_ops =3D {
>>>>>>>>>>>>  	.detach_group	=3D tce_iommu_detach_group,
>>>>>>>>>>>>  };
>>>>>>>>>>>> =20
>>>>>>>>>>>> +struct iommu_table *vfio_container_spapr_tce_table_get_ext(=
void *iommu_data,
>>>>>>>>>>>> +		u64 offset)
>>>>>>>>>>>> +{
>>>>>>>>>>>> +	struct tce_container *container =3D iommu_data;
>>>>>>>>>>>> +	struct iommu_table *tbl =3D NULL;
>>>>>>>>>>>> +
>>>>>>>>>>>> +	if (tce_iommu_find_table(container, offset, &tbl) < 0)
>>>>>>>>>>>> +		return NULL;
>>>>>>>>>>>> +
>>>>>>>>>>>> +	iommu_table_get(tbl);
>>>>>>>>>>>> +
>>>>>>>>>>>> +	return tbl;
>>>>>>>>>>>> +}
>>>>>>>>>>>> +EXPORT_SYMBOL_GPL(vfio_container_spapr_tce_table_get_ext);
>>>>>>>>>>>> +
>>>>>>>>>>>>  static int __init tce_iommu_init(void)
>>>>>>>>>>>>  {
>>>>>>>>>>>>  	return vfio_register_iommu_driver(&tce_iommu_driver_ops);
>>>>>>>>>>>> @@ -1348,4 +1363,3 @@ MODULE_VERSION(DRIVER_VERSION);
>>>>>>>>>>>>  MODULE_LICENSE("GPL v2");
>>>>>>>>>>>>  MODULE_AUTHOR(DRIVER_AUTHOR);
>>>>>>>>>>>>  MODULE_DESCRIPTION(DRIVER_DESC);
>>>>>>>>>>>> -
>>>>>>>>>>>> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
>>>>>>>>>>>> index 0ecae0b..1c2138a 100644
>>>>>>>>>>>> --- a/include/linux/vfio.h
>>>>>>>>>>>> +++ b/include/linux/vfio.h
>>>>>>>>>>>> @@ -91,6 +91,12 @@ extern void vfio_group_put_external_user(=
struct vfio_group *group);
>>>>>>>>>>>>  extern int vfio_external_user_iommu_id(struct vfio_group *g=
roup);
>>>>>>>>>>>>  extern long vfio_external_check_extension(struct vfio_group=
 *group,
>>>>>>>>>>>>  					  unsigned long arg);
>>>>>>>>>>>> +extern struct vfio_container *vfio_container_get_ext(struct=
 file *filep);
>>>>>>>>>>>> +extern void vfio_container_put_ext(struct vfio_container *c=
ontainer);
>>>>>>>>>>>> +extern void *vfio_container_get_iommu_data_ext(
>>>>>>>>>>>> +		struct vfio_container *container);
>>>>>>>>>>>> +extern struct iommu_table *vfio_container_spapr_tce_table_g=
et_ext(
>>>>>>>>>>>> +		void *iommu_data, u64 offset);
>>>>>>>>>>>> =20
>>>>>>>>>>>>  /*
>>>>>>>>>>>>   * Sub-module helpers     =20
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I think you need to take a closer look of the lifecycle of a =
container,
>>>>>>>>>>> having a reference means the container itself won't go away, =
but only
>>>>>>>>>>> having a group set within that container holds the actual IOM=
MU
>>>>>>>>>>> references.  container->iommu_data is going to be NULL once t=
he
>>>>>>>>>>> groups are lost.  Thanks,     =20
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Container owns the iommu tables and this is what I care about =
here, groups
>>>>>>>>>> attached or not - this is handled separately via IOMMU group l=
ist in a
>>>>>>>>>> specific iommu_table struct, these groups get detached from io=
mmu_table
>>>>>>>>>> when they are removed from a container.   =20
>>>>>>>>>
>>>>>>>>> The container doesn't own anything, the container is privileged=
 by the
>>>>>>>>> groups being attached to it.  When groups are closed, they deta=
ch from
>>>>>>>>> the container and once the container group list is empty the io=
mmu
>>>>>>>>> backend is released and iommu_data is NULL.  A container refere=
nce
>>>>>>>>> doesn't give you what you're looking for.  It implies nothing a=
bout the
>>>>>>>>> iommu backend.   =20
>>>>>>>>
>>>>>>>>
>>>>>>>> Well. Backend is a part of a container and since a backend owns =
tables, a
>>>>>>>> container owns them too. =20
>>>>>>>
>>>>>>> The IOMMU backend is accessed through the container, but that bac=
kend
>>>>>>> is privileged by the groups it contains.  Once those groups are g=
one,
>>>>>>> the IOMMU backend is released, regardless of whatever reference y=
ou
>>>>>>> have to the container itself such as you're attempting to do here=
=2E  In
>>>>>>> that sense, the container does not own those tables. =20
>>>>>>
>>>>>> So, the thing is that what KVM fundamentally needs is a handle on =
the
>>>>>> container.  KVM is essentially modelling the DMA address space of =
a
>>>>>> single guest bus, and the container is what's attached to that.
>>>>>>
>>>>>> The first part of the problem is that KVM wants to basically invok=
e
>>>>>> vfio_dma_map() operations without bouncing via qemu.  Because
>>>>>> vfio_dma_map() works on the container level, that's the handle tha=
t
>>>>>> KVM needs to hold.
>>>>>>
>>>>>> The second part of the problem is that in order to reduce overhead=

>>>>>> further, we want to operate in real mode, which means bypassing mo=
st
>>>>>> of the usual VFIO structure and going directly(ish) from the KVM
>>>>>> hcall emulation to the IOMMU backend behind VFIO.  This complicate=
s
>>>>>> matters a fair bit.  Because it is, explicitly, a performance hack=
,
>>>>>> some degree of ugliness is probably inevitable.
>>>>>>
>>>>>> Alexey - actually implementing this in two stages might make this
>>>>>> clearer.  The first stage wouldn't allow real mode, and would call=

>>>>>> through the same vfio_dma_map() path as qemu calls through now.  T=
he
>>>>>> second stage would then put in place the necessary hacks to add re=
al
>>>>>> mode support.
>>>>>>
>>>>>>>> The problem I am trying to solve here is when KVM may release th=
e
>>>>>>>> iommu_table objects.
>>>>>>>>
>>>>>>>> "Set" ioctl() to KVM-spapr-tce-table (or KVM itself, does not re=
ally
>>>>>>>> matter) makes a link between KVM-spapr-tce-table and container a=
nd KVM can
>>>>>>>> start using tables (with referencing them).
>>>>>>>>
>>>>>>>> First I tried adding an "unset" ioctl to KVM-spapr-tce-table, ca=
lled it
>>>>>>>> from region_del() and this works if QEMU removes a window. Howev=
er if QEMU
>>>>>>>> removes a vfio-pci device, region_del() is not called and KVM do=
es not get
>>>>>>>> notified that it can release the iommu_table's because the
>>>>>>>> KVM-spapr-tce-table remains alive and does not get destroyed (as=
 it is
>>>>>>>> still used by emulated devices or other containers).
>>>>>>>>
>>>>>>>> So it was suggested that we could do such "unset" somehow later =
assuming,
>>>>>>>> for example, on every "set" I could check if some of currently a=
ttached
>>>>>>>> containers are no more used - and this is where being able to kn=
ow if there
>>>>>>>> is no backend helps - KVM remembers a container pointer and can =
check this
>>>>>>>> via vfio_container_get_iommu_data_ext().
>>>>>>>>
>>>>>>>> The other option would be changing vfio_container_get_ext() to t=
ake a
>>>>>>>> callback+opaque which container would call when it destroys iomm=
u_data.
>>>>>>>> This looks more intrusive and not very intuitive how to make it =
right -
>>>>>>>> container would have to keep track of all registered external us=
ers and
>>>>>>>> vfio_container_put_ext() would have to pass the same callback+op=
aque to
>>>>>>>> unregister the exact external user. =20
>>>>>>>
>>>>>>> I'm not in favor of anything resembling the code above or extensi=
ons
>>>>>>> beyond it, the container is the wrong place to do this.
>>>>>>>  =20
>>>>>>>> Or I could store container file* in KVM. Then iommu_data would n=
ever be
>>>>>>>> released until KVM-spapr-tce-table is destroyed. =20
>>>>>>>
>>>>>>> See above, holding a file pointer to the container doesn't do squ=
at.
>>>>>>> The groups that are held by the container empower the IOMMU backe=
nd,
>>>>>>> references to the container itself don't matter.  Those reference=
s will
>>>>>>> not maintain the IOMMU data.
>>>>>>>   =20
>>>>>>>> Recreating KVM-spapr-tce-table on every vfio-pci hotunplug (clos=
ing its fd
>>>>>>>> would "unset" container from KVM-spapr-tce-table) is not an opti=
on as there
>>>>>>>> still may be devices using this KVM-spapr-tce-table.
>>>>>>>>
>>>>>>>> What obvious and nice solution am I missing here? Thanks. =20
>>>>>>>
>>>>>>> The interactions with the IOMMU backend that seem relevant are
>>>>>>> vfio_iommu_drivers_ops.{detach_group,release}.  The kvm-vfio pseu=
do
>>>>>>> device is also used to tell kvm about groups as they come and go =
and
>>>>>>> has a way to check extensions, and thus properties of the IOMMU
>>>>>>> backend.  All of these are available for your {ab}use.  Thanks,  =

>>>>>>
>>>>>> So, Alexey started trying to do this via the KVM-VFIO device, but =
it's
>>>>>> a really bad fit.  As noted above, fundamentally it's a container =
we
>>>>>> need to attach to the kvm-spapr-tce-table object, since what that
>>>>>> represents is a guest bus DMA address space, and by definition all=
 the
>>>>>> groups in a container must have the same DMA address space.
>>>>>
>>>>> That's all fine and good, but the point remains that a reference to=
 the
>>>>> container is no assurance of the iommu state.  The iommu state is
>>>>> maintained by the user and the groups attached to the container.  I=
f
>>>>> the groups are removed, your container reference no long has any io=
mmu
>>>>> backing and iommu_data is worthless.  The user can do this as well =
by
>>>>> un-setting the iommu.  I understand what you're trying to do, it's =
just
>>>>> wrong.  Thanks,
>>>>
>>>> I'm trying to figure out how to do this right, and it's not at all
>>>> obvious.  The container may be wrong, but that doesn't have the
>>>> KVM-VFIO device any more useful.  Attempting to do this at the group=

>>>> level is at least as wrong for the reasons I've mentioned elsewhere.=

>>>>
>>>
>>> I could create a new fd, one per iommu_table, the fd would reference =
the
>>> iommu_table (not touching an iommu_table_group or a container), VFIO =
SPAPR
>>> TCE backend would return it in VFIO_IOMMU_SPAPR_TCE_CREATE (ioctl whi=
ch
>>> creates windows) or I could add VFIO_IOMMU_SPAPR_TCE_GET_FD_BY_OFFSET=
; then
>>> I'd pass this new fd to the KVM or KVM-spapr-tce-table to hook them u=
p. To
>>> release the reference, KVM-spapr-tce-table would have "unset" ioctl()=

>>> or/and on every "set" I would look if all attached tables have at lea=
st one
>>> iommu_table_group attached, if none - release the table.
>>>
>>> This would make no change to generic VFIO code and very little change=
 in
>>> SPAPR TCE backend. Would that be acceptable or it is horrible again? =
Thanks.
>>
>>
>> Ping?
>=20
> I'm still in Toronto after KVM Forum.  I had a detailed discussion
> about this with Alex W, which I'll write up once I get back.
>=20
> The short version is that Alex more-or-less convinced me that we do
> need to go back to doing this with an interface based on linking
> groups to LIOBNs.  That leads to an interface that's kind of weird and
> has some fairly counter-intuitive properties, but in the end it works
> out better than doing it with containers.
>=20




Soooo? :)




--=20
Alexey


--5TFTSKpIjlbM3iL7ELFHKIGQjxd5lnCL9--

--uVKcb3I4egwwtgOEdTirGQHbcFGR3aaNk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXz9ljAAoJEIYTPdgrwSC5kGIQALTjCxp5S2Gx9+g4qURIaXmS
hb5tjRNwhMV5M7+MKbBh1HdEI8RbND7Vr7e0eKPNubyIyJiVrYcFTHjPqNPsc7wX
7cqMDZb7hhMd898iEkmb18AAbOZ0oUM7Dx2IbbIjAnGn/lQnvTM8OrfGCYDsJcQL
pqo7C3eqSOsahSnCE9/okLcUHDXdyxW0SJFyrn+0IIBac10nb87rdSIrJKS2vln0
l6uL7Q7Eng01J+QVqI7ZEfPexWnUnfs+ogfPCvMXZmMCC3FIsuF2QmVGNFyRs7K/
C6MZHKIeVExbmcDHWwkFL4tyGdvdfAMQHAhtZAPT/2GCrkufWLJl51TDDTwsqo0I
QYt8OOjtCwnNMsU90BZpBGqABXEZE6ULR+nUe7ZSg56rWQWGFlO1anGIFSeWILcn
bg8+1yrRDd2nsusg2g0GD46NWf+YbK42ysf+VBwE9JuvmAvoYKN4HEakas/HBTns
e0bJ0O5W8OucR9mushwkMJ6n4ALf+oKweOCgKNDfAQVB/Y24HXZCWMFs0rhdAkyo
oaUqwVfXK2jcopW3u4tUdCIUM5PSRbb0mSAIX3lFa1slMFfzm1C8+3xQH+wLz7Pb
8h6aqgDiRu4uY49DbJh9/JZl14BPoCk+wOlSumdAub7Rq+///7q91jfEIrFwGbFM
0VMLf82wvLSgIeROfF17
=giDj
-----END PGP SIGNATURE-----

--uVKcb3I4egwwtgOEdTirGQHbcFGR3aaNk--
