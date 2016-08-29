Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sN22h60TCzDrgc
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 16:35:24 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id i6so8752303pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 23:35:24 -0700 (PDT)
Subject: Re: [PATCH kernel 14/15] vfio/spapr_tce: Export container API for
 external users
To: David Gibson <david@gibson.dropbear.id.au>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
 <1470213656-1042-15-git-send-email-aik@ozlabs.ru>
 <20160808104315.77cf22ec@t450s.home>
 <f338a1d3-438a-9004-9645-87a16b9baf79@ozlabs.ru>
 <20160809061630.50ed5536@t450s.home>
 <4d1ea52b-ecb5-5f9b-6cdc-00a73677cc2f@ozlabs.ru>
 <20160810104630.21ab4bc5@t450s.home> <20160812054601.GS16493@voom.fritz.box>
 <20160812092201.243f4e15@t450s.home> <20160817031725.GM14530@voom.fritz.box>
 <2273cf1c-babb-fbe1-c1e4-487291b9910a@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <f339c165-d24a-76e4-b3cd-b3d73e325421@ozlabs.ru>
Date: Mon, 29 Aug 2016 16:35:15 +1000
MIME-Version: 1.0
In-Reply-To: <2273cf1c-babb-fbe1-c1e4-487291b9910a@ozlabs.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ocX2qduxiIiNqPndtRwbHmOvUspu4q4Br"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ocX2qduxiIiNqPndtRwbHmOvUspu4q4Br
Content-Type: multipart/mixed; boundary="oBocOOKWQ2QEWWGStN3Endq2FbvG9bh3o"
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
Message-ID: <f339c165-d24a-76e4-b3cd-b3d73e325421@ozlabs.ru>
Subject: Re: [PATCH kernel 14/15] vfio/spapr_tce: Export container API for
 external users
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
 <1470213656-1042-15-git-send-email-aik@ozlabs.ru>
 <20160808104315.77cf22ec@t450s.home>
 <f338a1d3-438a-9004-9645-87a16b9baf79@ozlabs.ru>
 <20160809061630.50ed5536@t450s.home>
 <4d1ea52b-ecb5-5f9b-6cdc-00a73677cc2f@ozlabs.ru>
 <20160810104630.21ab4bc5@t450s.home> <20160812054601.GS16493@voom.fritz.box>
 <20160812092201.243f4e15@t450s.home> <20160817031725.GM14530@voom.fritz.box>
 <2273cf1c-babb-fbe1-c1e4-487291b9910a@ozlabs.ru>
In-Reply-To: <2273cf1c-babb-fbe1-c1e4-487291b9910a@ozlabs.ru>

--oBocOOKWQ2QEWWGStN3Endq2FbvG9bh3o
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 18/08/16 10:22, Alexey Kardashevskiy wrote:
> On 17/08/16 13:17, David Gibson wrote:
>> On Fri, Aug 12, 2016 at 09:22:01AM -0600, Alex Williamson wrote:
>>> On Fri, 12 Aug 2016 15:46:01 +1000
>>> David Gibson <david@gibson.dropbear.id.au> wrote:
>>>
>>>> On Wed, Aug 10, 2016 at 10:46:30AM -0600, Alex Williamson wrote:
>>>>> On Wed, 10 Aug 2016 15:37:17 +1000
>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>>>  =20
>>>>>> On 09/08/16 22:16, Alex Williamson wrote: =20
>>>>>>> On Tue, 9 Aug 2016 15:19:39 +1000
>>>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>>>>>    =20
>>>>>>>> On 09/08/16 02:43, Alex Williamson wrote:   =20
>>>>>>>>> On Wed,  3 Aug 2016 18:40:55 +1000
>>>>>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>>>>>>>      =20
>>>>>>>>>> This exports helpers which are needed to keep a VFIO container=
 in
>>>>>>>>>> memory while there are external users such as KVM.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>>>>>>>> ---
>>>>>>>>>>  drivers/vfio/vfio.c                 | 30 ++++++++++++++++++++=
++++++++++
>>>>>>>>>>  drivers/vfio/vfio_iommu_spapr_tce.c | 16 +++++++++++++++-
>>>>>>>>>>  include/linux/vfio.h                |  6 ++++++
>>>>>>>>>>  3 files changed, 51 insertions(+), 1 deletion(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
>>>>>>>>>> index d1d70e0..baf6a9c 100644
>>>>>>>>>> --- a/drivers/vfio/vfio.c
>>>>>>>>>> +++ b/drivers/vfio/vfio.c
>>>>>>>>>> @@ -1729,6 +1729,36 @@ long vfio_external_check_extension(stru=
ct vfio_group *group, unsigned long arg)
>>>>>>>>>>  EXPORT_SYMBOL_GPL(vfio_external_check_extension);
>>>>>>>>>> =20
>>>>>>>>>>  /**
>>>>>>>>>> + * External user API for containers, exported by symbols to b=
e linked
>>>>>>>>>> + * dynamically.
>>>>>>>>>> + *
>>>>>>>>>> + */
>>>>>>>>>> +struct vfio_container *vfio_container_get_ext(struct file *fi=
lep)
>>>>>>>>>> +{
>>>>>>>>>> +	struct vfio_container *container =3D filep->private_data;
>>>>>>>>>> +
>>>>>>>>>> +	if (filep->f_op !=3D &vfio_fops)
>>>>>>>>>> +		return ERR_PTR(-EINVAL);
>>>>>>>>>> +
>>>>>>>>>> +	vfio_container_get(container);
>>>>>>>>>> +
>>>>>>>>>> +	return container;
>>>>>>>>>> +}
>>>>>>>>>> +EXPORT_SYMBOL_GPL(vfio_container_get_ext);
>>>>>>>>>> +
>>>>>>>>>> +void vfio_container_put_ext(struct vfio_container *container)=

>>>>>>>>>> +{
>>>>>>>>>> +	vfio_container_put(container);
>>>>>>>>>> +}
>>>>>>>>>> +EXPORT_SYMBOL_GPL(vfio_container_put_ext);
>>>>>>>>>> +
>>>>>>>>>> +void *vfio_container_get_iommu_data_ext(struct vfio_container=
 *container)
>>>>>>>>>> +{
>>>>>>>>>> +	return container->iommu_data;
>>>>>>>>>> +}
>>>>>>>>>> +EXPORT_SYMBOL_GPL(vfio_container_get_iommu_data_ext);
>>>>>>>>>> +
>>>>>>>>>> +/**
>>>>>>>>>>   * Sub-module support
>>>>>>>>>>   */
>>>>>>>>>>  /*
>>>>>>>>>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfi=
o/vfio_iommu_spapr_tce.c
>>>>>>>>>> index 3594ad3..fceea3d 100644
>>>>>>>>>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
>>>>>>>>>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>>>>>>>>>> @@ -1331,6 +1331,21 @@ const struct vfio_iommu_driver_ops tce_=
iommu_driver_ops =3D {
>>>>>>>>>>  	.detach_group	=3D tce_iommu_detach_group,
>>>>>>>>>>  };
>>>>>>>>>> =20
>>>>>>>>>> +struct iommu_table *vfio_container_spapr_tce_table_get_ext(vo=
id *iommu_data,
>>>>>>>>>> +		u64 offset)
>>>>>>>>>> +{
>>>>>>>>>> +	struct tce_container *container =3D iommu_data;
>>>>>>>>>> +	struct iommu_table *tbl =3D NULL;
>>>>>>>>>> +
>>>>>>>>>> +	if (tce_iommu_find_table(container, offset, &tbl) < 0)
>>>>>>>>>> +		return NULL;
>>>>>>>>>> +
>>>>>>>>>> +	iommu_table_get(tbl);
>>>>>>>>>> +
>>>>>>>>>> +	return tbl;
>>>>>>>>>> +}
>>>>>>>>>> +EXPORT_SYMBOL_GPL(vfio_container_spapr_tce_table_get_ext);
>>>>>>>>>> +
>>>>>>>>>>  static int __init tce_iommu_init(void)
>>>>>>>>>>  {
>>>>>>>>>>  	return vfio_register_iommu_driver(&tce_iommu_driver_ops);
>>>>>>>>>> @@ -1348,4 +1363,3 @@ MODULE_VERSION(DRIVER_VERSION);
>>>>>>>>>>  MODULE_LICENSE("GPL v2");
>>>>>>>>>>  MODULE_AUTHOR(DRIVER_AUTHOR);
>>>>>>>>>>  MODULE_DESCRIPTION(DRIVER_DESC);
>>>>>>>>>> -
>>>>>>>>>> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
>>>>>>>>>> index 0ecae0b..1c2138a 100644
>>>>>>>>>> --- a/include/linux/vfio.h
>>>>>>>>>> +++ b/include/linux/vfio.h
>>>>>>>>>> @@ -91,6 +91,12 @@ extern void vfio_group_put_external_user(st=
ruct vfio_group *group);
>>>>>>>>>>  extern int vfio_external_user_iommu_id(struct vfio_group *gro=
up);
>>>>>>>>>>  extern long vfio_external_check_extension(struct vfio_group *=
group,
>>>>>>>>>>  					  unsigned long arg);
>>>>>>>>>> +extern struct vfio_container *vfio_container_get_ext(struct f=
ile *filep);
>>>>>>>>>> +extern void vfio_container_put_ext(struct vfio_container *con=
tainer);
>>>>>>>>>> +extern void *vfio_container_get_iommu_data_ext(
>>>>>>>>>> +		struct vfio_container *container);
>>>>>>>>>> +extern struct iommu_table *vfio_container_spapr_tce_table_get=
_ext(
>>>>>>>>>> +		void *iommu_data, u64 offset);
>>>>>>>>>> =20
>>>>>>>>>>  /*
>>>>>>>>>>   * Sub-module helpers     =20
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I think you need to take a closer look of the lifecycle of a co=
ntainer,
>>>>>>>>> having a reference means the container itself won't go away, bu=
t only
>>>>>>>>> having a group set within that container holds the actual IOMMU=

>>>>>>>>> references.  container->iommu_data is going to be NULL once the=

>>>>>>>>> groups are lost.  Thanks,     =20
>>>>>>>>
>>>>>>>>
>>>>>>>> Container owns the iommu tables and this is what I care about he=
re, groups
>>>>>>>> attached or not - this is handled separately via IOMMU group lis=
t in a
>>>>>>>> specific iommu_table struct, these groups get detached from iomm=
u_table
>>>>>>>> when they are removed from a container.   =20
>>>>>>>
>>>>>>> The container doesn't own anything, the container is privileged b=
y the
>>>>>>> groups being attached to it.  When groups are closed, they detach=
 from
>>>>>>> the container and once the container group list is empty the iomm=
u
>>>>>>> backend is released and iommu_data is NULL.  A container referenc=
e
>>>>>>> doesn't give you what you're looking for.  It implies nothing abo=
ut the
>>>>>>> iommu backend.   =20
>>>>>>
>>>>>>
>>>>>> Well. Backend is a part of a container and since a backend owns ta=
bles, a
>>>>>> container owns them too. =20
>>>>>
>>>>> The IOMMU backend is accessed through the container, but that backe=
nd
>>>>> is privileged by the groups it contains.  Once those groups are gon=
e,
>>>>> the IOMMU backend is released, regardless of whatever reference you=

>>>>> have to the container itself such as you're attempting to do here. =
 In
>>>>> that sense, the container does not own those tables. =20
>>>>
>>>> So, the thing is that what KVM fundamentally needs is a handle on th=
e
>>>> container.  KVM is essentially modelling the DMA address space of a
>>>> single guest bus, and the container is what's attached to that.
>>>>
>>>> The first part of the problem is that KVM wants to basically invoke
>>>> vfio_dma_map() operations without bouncing via qemu.  Because
>>>> vfio_dma_map() works on the container level, that's the handle that
>>>> KVM needs to hold.
>>>>
>>>> The second part of the problem is that in order to reduce overhead
>>>> further, we want to operate in real mode, which means bypassing most=

>>>> of the usual VFIO structure and going directly(ish) from the KVM
>>>> hcall emulation to the IOMMU backend behind VFIO.  This complicates
>>>> matters a fair bit.  Because it is, explicitly, a performance hack,
>>>> some degree of ugliness is probably inevitable.
>>>>
>>>> Alexey - actually implementing this in two stages might make this
>>>> clearer.  The first stage wouldn't allow real mode, and would call
>>>> through the same vfio_dma_map() path as qemu calls through now.  The=

>>>> second stage would then put in place the necessary hacks to add real=

>>>> mode support.
>>>>
>>>>>> The problem I am trying to solve here is when KVM may release the
>>>>>> iommu_table objects.
>>>>>>
>>>>>> "Set" ioctl() to KVM-spapr-tce-table (or KVM itself, does not real=
ly
>>>>>> matter) makes a link between KVM-spapr-tce-table and container and=
 KVM can
>>>>>> start using tables (with referencing them).
>>>>>>
>>>>>> First I tried adding an "unset" ioctl to KVM-spapr-tce-table, call=
ed it
>>>>>> from region_del() and this works if QEMU removes a window. However=
 if QEMU
>>>>>> removes a vfio-pci device, region_del() is not called and KVM does=
 not get
>>>>>> notified that it can release the iommu_table's because the
>>>>>> KVM-spapr-tce-table remains alive and does not get destroyed (as i=
t is
>>>>>> still used by emulated devices or other containers).
>>>>>>
>>>>>> So it was suggested that we could do such "unset" somehow later as=
suming,
>>>>>> for example, on every "set" I could check if some of currently att=
ached
>>>>>> containers are no more used - and this is where being able to know=
 if there
>>>>>> is no backend helps - KVM remembers a container pointer and can ch=
eck this
>>>>>> via vfio_container_get_iommu_data_ext().
>>>>>>
>>>>>> The other option would be changing vfio_container_get_ext() to tak=
e a
>>>>>> callback+opaque which container would call when it destroys iommu_=
data.
>>>>>> This looks more intrusive and not very intuitive how to make it ri=
ght -
>>>>>> container would have to keep track of all registered external user=
s and
>>>>>> vfio_container_put_ext() would have to pass the same callback+opaq=
ue to
>>>>>> unregister the exact external user. =20
>>>>>
>>>>> I'm not in favor of anything resembling the code above or extension=
s
>>>>> beyond it, the container is the wrong place to do this.
>>>>>  =20
>>>>>> Or I could store container file* in KVM. Then iommu_data would nev=
er be
>>>>>> released until KVM-spapr-tce-table is destroyed. =20
>>>>>
>>>>> See above, holding a file pointer to the container doesn't do squat=
=2E
>>>>> The groups that are held by the container empower the IOMMU backend=
,
>>>>> references to the container itself don't matter.  Those references =
will
>>>>> not maintain the IOMMU data.
>>>>>   =20
>>>>>> Recreating KVM-spapr-tce-table on every vfio-pci hotunplug (closin=
g its fd
>>>>>> would "unset" container from KVM-spapr-tce-table) is not an option=
 as there
>>>>>> still may be devices using this KVM-spapr-tce-table.
>>>>>>
>>>>>> What obvious and nice solution am I missing here? Thanks. =20
>>>>>
>>>>> The interactions with the IOMMU backend that seem relevant are
>>>>> vfio_iommu_drivers_ops.{detach_group,release}.  The kvm-vfio pseudo=

>>>>> device is also used to tell kvm about groups as they come and go an=
d
>>>>> has a way to check extensions, and thus properties of the IOMMU
>>>>> backend.  All of these are available for your {ab}use.  Thanks, =20
>>>>
>>>> So, Alexey started trying to do this via the KVM-VFIO device, but it=
's
>>>> a really bad fit.  As noted above, fundamentally it's a container we=

>>>> need to attach to the kvm-spapr-tce-table object, since what that
>>>> represents is a guest bus DMA address space, and by definition all t=
he
>>>> groups in a container must have the same DMA address space.
>>>
>>> That's all fine and good, but the point remains that a reference to t=
he
>>> container is no assurance of the iommu state.  The iommu state is
>>> maintained by the user and the groups attached to the container.  If
>>> the groups are removed, your container reference no long has any iomm=
u
>>> backing and iommu_data is worthless.  The user can do this as well by=

>>> un-setting the iommu.  I understand what you're trying to do, it's ju=
st
>>> wrong.  Thanks,
>>
>> I'm trying to figure out how to do this right, and it's not at all
>> obvious.  The container may be wrong, but that doesn't have the
>> KVM-VFIO device any more useful.  Attempting to do this at the group
>> level is at least as wrong for the reasons I've mentioned elsewhere.
>>
>=20
> I could create a new fd, one per iommu_table, the fd would reference th=
e
> iommu_table (not touching an iommu_table_group or a container), VFIO SP=
APR
> TCE backend would return it in VFIO_IOMMU_SPAPR_TCE_CREATE (ioctl which=

> creates windows) or I could add VFIO_IOMMU_SPAPR_TCE_GET_FD_BY_OFFSET; =
then
> I'd pass this new fd to the KVM or KVM-spapr-tce-table to hook them up.=
 To
> release the reference, KVM-spapr-tce-table would have "unset" ioctl()
> or/and on every "set" I would look if all attached tables have at least=
 one
> iommu_table_group attached, if none - release the table.
>=20
> This would make no change to generic VFIO code and very little change i=
n
> SPAPR TCE backend. Would that be acceptable or it is horrible again? Th=
anks.


Ping?



--=20
Alexey


--oBocOOKWQ2QEWWGStN3Endq2FbvG9bh3o--

--ocX2qduxiIiNqPndtRwbHmOvUspu4q4Br
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXw9ejAAoJEIYTPdgrwSC5iKcQAInRUaPI/IGoTTl7UhOQ++4E
LSkB18XQN6z0A6ejcYaOGkBAN/eRTKMI83L8/DQmSX+G6ToRjLTI6MyIai9MPa85
PqINeMj7Ms5w6USS/FMLWqAj4iW4PBRLZ+3OPQRxL2Q5z3ODq9+vWRoklQu6i1PT
h+Wgh5n5Z/LrjelqA30RuDubDTq/UJhVEwashicer8R19ZKYy12Ug7u870UXp7Z8
3EIJqR2IZBe7kVF4CUpnuzY0uoNEzaWK5Q1P7qBCJlkii7/q+N0HUN9Ca0HyvWOi
j5ifie5Sr7iNNWx5Nt04dp1Zma8EOE8iLegwZm4lW+20akkBRVMhQu5BlJE1pjmZ
ygVNfDolcS0O+plbqT0Vl6v5dx5mZZgSc2h6naBic12j4ZoErMoc7z1f0cQhFHxh
tRqEqLhvZgGOE6b/+9/tQy+nCt8utVVjC4SMC46CX03eZ6zhwdVv3PFZD6dozeTl
LpTs8wybdoHx8E/JhnhLbQyb8rrzgX3OwwbQsDVdr2R09YQTGoaS/pGGnlhHoLxh
qqTlsvlGsKGNCchmI/3XYootJwZsK6lX8S5DEcVoSuQFI0Izml9zoDFlS+yD4phI
DhddGpcSBVkVQ0pAo6YVY8GJJgT2KYIKpP7tnNf7sPQYCBLsl6G/9kXi2MvZ6ASK
YIxPbjDVqjLEJxAmST2+
=rMa+
-----END PGP SIGNATURE-----

--ocX2qduxiIiNqPndtRwbHmOvUspu4q4Br--
