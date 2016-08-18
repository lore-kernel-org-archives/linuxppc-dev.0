Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sF6J958w2zDr4c
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 10:23:05 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id g202so375617pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 17:23:04 -0700 (PDT)
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <2273cf1c-babb-fbe1-c1e4-487291b9910a@ozlabs.ru>
Date: Thu, 18 Aug 2016 10:22:57 +1000
MIME-Version: 1.0
In-Reply-To: <20160817031725.GM14530@voom.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NMbL1q6cbJpNaDU1DpRmi2aTC5MgXtbKA"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NMbL1q6cbJpNaDU1DpRmi2aTC5MgXtbKA
Content-Type: multipart/mixed; boundary="6O4ANTNmxDP76fOQPlD4I0UpOmBBXuhXk"
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
Message-ID: <2273cf1c-babb-fbe1-c1e4-487291b9910a@ozlabs.ru>
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
In-Reply-To: <20160817031725.GM14530@voom.fritz.box>

--6O4ANTNmxDP76fOQPlD4I0UpOmBBXuhXk
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 17/08/16 13:17, David Gibson wrote:
> On Fri, Aug 12, 2016 at 09:22:01AM -0600, Alex Williamson wrote:
>> On Fri, 12 Aug 2016 15:46:01 +1000
>> David Gibson <david@gibson.dropbear.id.au> wrote:
>>
>>> On Wed, Aug 10, 2016 at 10:46:30AM -0600, Alex Williamson wrote:
>>>> On Wed, 10 Aug 2016 15:37:17 +1000
>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>>  =20
>>>>> On 09/08/16 22:16, Alex Williamson wrote: =20
>>>>>> On Tue, 9 Aug 2016 15:19:39 +1000
>>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>>>>    =20
>>>>>>> On 09/08/16 02:43, Alex Williamson wrote:   =20
>>>>>>>> On Wed,  3 Aug 2016 18:40:55 +1000
>>>>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>>>>>>      =20
>>>>>>>>> This exports helpers which are needed to keep a VFIO container =
in
>>>>>>>>> memory while there are external users such as KVM.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>>>>>>> ---
>>>>>>>>>  drivers/vfio/vfio.c                 | 30 +++++++++++++++++++++=
+++++++++
>>>>>>>>>  drivers/vfio/vfio_iommu_spapr_tce.c | 16 +++++++++++++++-
>>>>>>>>>  include/linux/vfio.h                |  6 ++++++
>>>>>>>>>  3 files changed, 51 insertions(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
>>>>>>>>> index d1d70e0..baf6a9c 100644
>>>>>>>>> --- a/drivers/vfio/vfio.c
>>>>>>>>> +++ b/drivers/vfio/vfio.c
>>>>>>>>> @@ -1729,6 +1729,36 @@ long vfio_external_check_extension(struc=
t vfio_group *group, unsigned long arg)
>>>>>>>>>  EXPORT_SYMBOL_GPL(vfio_external_check_extension);
>>>>>>>>> =20
>>>>>>>>>  /**
>>>>>>>>> + * External user API for containers, exported by symbols to be=
 linked
>>>>>>>>> + * dynamically.
>>>>>>>>> + *
>>>>>>>>> + */
>>>>>>>>> +struct vfio_container *vfio_container_get_ext(struct file *fil=
ep)
>>>>>>>>> +{
>>>>>>>>> +	struct vfio_container *container =3D filep->private_data;
>>>>>>>>> +
>>>>>>>>> +	if (filep->f_op !=3D &vfio_fops)
>>>>>>>>> +		return ERR_PTR(-EINVAL);
>>>>>>>>> +
>>>>>>>>> +	vfio_container_get(container);
>>>>>>>>> +
>>>>>>>>> +	return container;
>>>>>>>>> +}
>>>>>>>>> +EXPORT_SYMBOL_GPL(vfio_container_get_ext);
>>>>>>>>> +
>>>>>>>>> +void vfio_container_put_ext(struct vfio_container *container)
>>>>>>>>> +{
>>>>>>>>> +	vfio_container_put(container);
>>>>>>>>> +}
>>>>>>>>> +EXPORT_SYMBOL_GPL(vfio_container_put_ext);
>>>>>>>>> +
>>>>>>>>> +void *vfio_container_get_iommu_data_ext(struct vfio_container =
*container)
>>>>>>>>> +{
>>>>>>>>> +	return container->iommu_data;
>>>>>>>>> +}
>>>>>>>>> +EXPORT_SYMBOL_GPL(vfio_container_get_iommu_data_ext);
>>>>>>>>> +
>>>>>>>>> +/**
>>>>>>>>>   * Sub-module support
>>>>>>>>>   */
>>>>>>>>>  /*
>>>>>>>>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio=
/vfio_iommu_spapr_tce.c
>>>>>>>>> index 3594ad3..fceea3d 100644
>>>>>>>>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
>>>>>>>>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>>>>>>>>> @@ -1331,6 +1331,21 @@ const struct vfio_iommu_driver_ops tce_i=
ommu_driver_ops =3D {
>>>>>>>>>  	.detach_group	=3D tce_iommu_detach_group,
>>>>>>>>>  };
>>>>>>>>> =20
>>>>>>>>> +struct iommu_table *vfio_container_spapr_tce_table_get_ext(voi=
d *iommu_data,
>>>>>>>>> +		u64 offset)
>>>>>>>>> +{
>>>>>>>>> +	struct tce_container *container =3D iommu_data;
>>>>>>>>> +	struct iommu_table *tbl =3D NULL;
>>>>>>>>> +
>>>>>>>>> +	if (tce_iommu_find_table(container, offset, &tbl) < 0)
>>>>>>>>> +		return NULL;
>>>>>>>>> +
>>>>>>>>> +	iommu_table_get(tbl);
>>>>>>>>> +
>>>>>>>>> +	return tbl;
>>>>>>>>> +}
>>>>>>>>> +EXPORT_SYMBOL_GPL(vfio_container_spapr_tce_table_get_ext);
>>>>>>>>> +
>>>>>>>>>  static int __init tce_iommu_init(void)
>>>>>>>>>  {
>>>>>>>>>  	return vfio_register_iommu_driver(&tce_iommu_driver_ops);
>>>>>>>>> @@ -1348,4 +1363,3 @@ MODULE_VERSION(DRIVER_VERSION);
>>>>>>>>>  MODULE_LICENSE("GPL v2");
>>>>>>>>>  MODULE_AUTHOR(DRIVER_AUTHOR);
>>>>>>>>>  MODULE_DESCRIPTION(DRIVER_DESC);
>>>>>>>>> -
>>>>>>>>> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
>>>>>>>>> index 0ecae0b..1c2138a 100644
>>>>>>>>> --- a/include/linux/vfio.h
>>>>>>>>> +++ b/include/linux/vfio.h
>>>>>>>>> @@ -91,6 +91,12 @@ extern void vfio_group_put_external_user(str=
uct vfio_group *group);
>>>>>>>>>  extern int vfio_external_user_iommu_id(struct vfio_group *grou=
p);
>>>>>>>>>  extern long vfio_external_check_extension(struct vfio_group *g=
roup,
>>>>>>>>>  					  unsigned long arg);
>>>>>>>>> +extern struct vfio_container *vfio_container_get_ext(struct fi=
le *filep);
>>>>>>>>> +extern void vfio_container_put_ext(struct vfio_container *cont=
ainer);
>>>>>>>>> +extern void *vfio_container_get_iommu_data_ext(
>>>>>>>>> +		struct vfio_container *container);
>>>>>>>>> +extern struct iommu_table *vfio_container_spapr_tce_table_get_=
ext(
>>>>>>>>> +		void *iommu_data, u64 offset);
>>>>>>>>> =20
>>>>>>>>>  /*
>>>>>>>>>   * Sub-module helpers     =20
>>>>>>>>
>>>>>>>>
>>>>>>>> I think you need to take a closer look of the lifecycle of a con=
tainer,
>>>>>>>> having a reference means the container itself won't go away, but=
 only
>>>>>>>> having a group set within that container holds the actual IOMMU
>>>>>>>> references.  container->iommu_data is going to be NULL once the
>>>>>>>> groups are lost.  Thanks,     =20
>>>>>>>
>>>>>>>
>>>>>>> Container owns the iommu tables and this is what I care about her=
e, groups
>>>>>>> attached or not - this is handled separately via IOMMU group list=
 in a
>>>>>>> specific iommu_table struct, these groups get detached from iommu=
_table
>>>>>>> when they are removed from a container.   =20
>>>>>>
>>>>>> The container doesn't own anything, the container is privileged by=
 the
>>>>>> groups being attached to it.  When groups are closed, they detach =
from
>>>>>> the container and once the container group list is empty the iommu=

>>>>>> backend is released and iommu_data is NULL.  A container reference=

>>>>>> doesn't give you what you're looking for.  It implies nothing abou=
t the
>>>>>> iommu backend.   =20
>>>>>
>>>>>
>>>>> Well. Backend is a part of a container and since a backend owns tab=
les, a
>>>>> container owns them too. =20
>>>>
>>>> The IOMMU backend is accessed through the container, but that backen=
d
>>>> is privileged by the groups it contains.  Once those groups are gone=
,
>>>> the IOMMU backend is released, regardless of whatever reference you
>>>> have to the container itself such as you're attempting to do here.  =
In
>>>> that sense, the container does not own those tables. =20
>>>
>>> So, the thing is that what KVM fundamentally needs is a handle on the=

>>> container.  KVM is essentially modelling the DMA address space of a
>>> single guest bus, and the container is what's attached to that.
>>>
>>> The first part of the problem is that KVM wants to basically invoke
>>> vfio_dma_map() operations without bouncing via qemu.  Because
>>> vfio_dma_map() works on the container level, that's the handle that
>>> KVM needs to hold.
>>>
>>> The second part of the problem is that in order to reduce overhead
>>> further, we want to operate in real mode, which means bypassing most
>>> of the usual VFIO structure and going directly(ish) from the KVM
>>> hcall emulation to the IOMMU backend behind VFIO.  This complicates
>>> matters a fair bit.  Because it is, explicitly, a performance hack,
>>> some degree of ugliness is probably inevitable.
>>>
>>> Alexey - actually implementing this in two stages might make this
>>> clearer.  The first stage wouldn't allow real mode, and would call
>>> through the same vfio_dma_map() path as qemu calls through now.  The
>>> second stage would then put in place the necessary hacks to add real
>>> mode support.
>>>
>>>>> The problem I am trying to solve here is when KVM may release the
>>>>> iommu_table objects.
>>>>>
>>>>> "Set" ioctl() to KVM-spapr-tce-table (or KVM itself, does not reall=
y
>>>>> matter) makes a link between KVM-spapr-tce-table and container and =
KVM can
>>>>> start using tables (with referencing them).
>>>>>
>>>>> First I tried adding an "unset" ioctl to KVM-spapr-tce-table, calle=
d it
>>>>> from region_del() and this works if QEMU removes a window. However =
if QEMU
>>>>> removes a vfio-pci device, region_del() is not called and KVM does =
not get
>>>>> notified that it can release the iommu_table's because the
>>>>> KVM-spapr-tce-table remains alive and does not get destroyed (as it=
 is
>>>>> still used by emulated devices or other containers).
>>>>>
>>>>> So it was suggested that we could do such "unset" somehow later ass=
uming,
>>>>> for example, on every "set" I could check if some of currently atta=
ched
>>>>> containers are no more used - and this is where being able to know =
if there
>>>>> is no backend helps - KVM remembers a container pointer and can che=
ck this
>>>>> via vfio_container_get_iommu_data_ext().
>>>>>
>>>>> The other option would be changing vfio_container_get_ext() to take=
 a
>>>>> callback+opaque which container would call when it destroys iommu_d=
ata.
>>>>> This looks more intrusive and not very intuitive how to make it rig=
ht -
>>>>> container would have to keep track of all registered external users=
 and
>>>>> vfio_container_put_ext() would have to pass the same callback+opaqu=
e to
>>>>> unregister the exact external user. =20
>>>>
>>>> I'm not in favor of anything resembling the code above or extensions=

>>>> beyond it, the container is the wrong place to do this.
>>>>  =20
>>>>> Or I could store container file* in KVM. Then iommu_data would neve=
r be
>>>>> released until KVM-spapr-tce-table is destroyed. =20
>>>>
>>>> See above, holding a file pointer to the container doesn't do squat.=

>>>> The groups that are held by the container empower the IOMMU backend,=

>>>> references to the container itself don't matter.  Those references w=
ill
>>>> not maintain the IOMMU data.
>>>>   =20
>>>>> Recreating KVM-spapr-tce-table on every vfio-pci hotunplug (closing=
 its fd
>>>>> would "unset" container from KVM-spapr-tce-table) is not an option =
as there
>>>>> still may be devices using this KVM-spapr-tce-table.
>>>>>
>>>>> What obvious and nice solution am I missing here? Thanks. =20
>>>>
>>>> The interactions with the IOMMU backend that seem relevant are
>>>> vfio_iommu_drivers_ops.{detach_group,release}.  The kvm-vfio pseudo
>>>> device is also used to tell kvm about groups as they come and go and=

>>>> has a way to check extensions, and thus properties of the IOMMU
>>>> backend.  All of these are available for your {ab}use.  Thanks, =20
>>>
>>> So, Alexey started trying to do this via the KVM-VFIO device, but it'=
s
>>> a really bad fit.  As noted above, fundamentally it's a container we
>>> need to attach to the kvm-spapr-tce-table object, since what that
>>> represents is a guest bus DMA address space, and by definition all th=
e
>>> groups in a container must have the same DMA address space.
>>
>> That's all fine and good, but the point remains that a reference to th=
e
>> container is no assurance of the iommu state.  The iommu state is
>> maintained by the user and the groups attached to the container.  If
>> the groups are removed, your container reference no long has any iommu=

>> backing and iommu_data is worthless.  The user can do this as well by
>> un-setting the iommu.  I understand what you're trying to do, it's jus=
t
>> wrong.  Thanks,
>=20
> I'm trying to figure out how to do this right, and it's not at all
> obvious.  The container may be wrong, but that doesn't have the
> KVM-VFIO device any more useful.  Attempting to do this at the group
> level is at least as wrong for the reasons I've mentioned elsewhere.
>=20

I could create a new fd, one per iommu_table, the fd would reference the
iommu_table (not touching an iommu_table_group or a container), VFIO SPAP=
R
TCE backend would return it in VFIO_IOMMU_SPAPR_TCE_CREATE (ioctl which
creates windows) or I could add VFIO_IOMMU_SPAPR_TCE_GET_FD_BY_OFFSET; th=
en
I'd pass this new fd to the KVM or KVM-spapr-tce-table to hook them up. T=
o
release the reference, KVM-spapr-tce-table would have "unset" ioctl()
or/and on every "set" I would look if all attached tables have at least o=
ne
iommu_table_group attached, if none - release the table.

This would make no change to generic VFIO code and very little change in
SPAPR TCE backend. Would that be acceptable or it is horrible again? Than=
ks.




--=20
Alexey


--6O4ANTNmxDP76fOQPlD4I0UpOmBBXuhXk--

--NMbL1q6cbJpNaDU1DpRmi2aTC5MgXtbKA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXtP/hAAoJEIYTPdgrwSC5aloQAL6L7H+UTODEe3P3mEFjWQSy
JsBO5H4bNRZFT8NpPGnxcRf9yc4FWCt38L+qh+zkiuYJXHtYTP5uku28cQpxUkVy
gcYgWjp6huaFi+zPPZfu/WalKD1bAssIweZu24XIKHSO8NSftk46RvqTGJ2qhqwl
8pu+5LzdiczezF+UMF1HKaD79FpKQq8JY7EIqE8MM603HNekFjV5bwqqtU7NXm8n
hD+b6amcUcM6hE5C3HcD63tQZHtrW/PIigQXhW7a1X4Ko7mPCt/V+0NNX0vT27Fq
xepYH565bYS4jkWrPic7t0A0q+ZpjBwfJ/BRO6KfmJQYvzmDDXKsX0B/ss86sHhx
pymUAOyTovgG2WsKdrNM+qMIPZtjBshzLyJz4XBGjUmTKxEGG0xL3lXehth5NKmb
oV3yVGBXdWztgkg1qh1KOV3v93NpTj+HxOwNhdP4ynsdTOWJr9DAXswCGdwkqm1p
VfdbSrx6YlLWhFuEo1J6fkuAVgzppRjQQkXIQixAJWSzrm7hd94XSmzSjCH6BlYo
mYbpVZGVeCVu7owfXVJQk1O7F8aYth5kl4HWyJNzvlJYbU10iKUB/XOtg8aQMmfZ
5tJPrwhFwxAKdY7+pG3tm/vfc4F5xMBbOq9FvmE5LSAe/7G+Jn4Hk6Hsro/CqdCc
XrYp4yTiuV/bnfYFHljH
=Ge7X
-----END PGP SIGNATURE-----

--NMbL1q6cbJpNaDU1DpRmi2aTC5MgXtbKA--
