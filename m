Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qPKG92HsvzDqGd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 14:04:17 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 14 Mar 2016 23:04:14 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 879256E8040
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Mar 2016 22:51:02 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2F34Bcn31457354
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 03:04:12 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2F2xRj2008830
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Mar 2016 22:59:27 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC] powerpc/devtree: Parse new DRC mem/cpu/dev device tree
 elements
In-Reply-To: <56E5AEDA.3050608@linux.vnet.ibm.com>
References: <56E5AEDA.3050608@linux.vnet.ibm.com>
Date: Tue, 15 Mar 2016 14:03:57 +1100
Message-ID: <87twk85tnm.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
> Summary: The following properties: ibm,drc-indexes, ibm,drc-names,=20
> ibm,drc-types and ibm,drc-power-domains will be combined and condensed=20
> into the single property, ibm,drc-info.
>
> The ibm,dynamic-memory property will be condensed into a new version,=20
> ibm,dynamic-memory-v2.
>
> Note: "[PATCH] powerpc/devtree: Parse new DRC mem/cpu/dev device tree=20
> elements" is withdrawn at this time.
>
>
> Several properties in the DRC device tree format are replaced by
> more compact representations to allow, for example, for the encoding
> of vast amounts of memory, and or reduced duplication of information
> in related data structures.
>
> "ibm,drc-info": This property, when present, replaces the following
> four properties: =E2=80=9Cibm,drc-indexes=E2=80=9D, =E2=80=9Cibm,drc-name=
s=E2=80=9D, =E2=80=9Cibm,drc-types=E2=80=9D
> and =E2=80=9Cibm,drc-power-domains=E2=80=9D.  This property is defined fo=
r all
> dynamically reconfigurable platform nodes.  The "ibm,drc-info" elements
> are intended to provide a more compact representation, and reduce some
> search overhead.
>
> "ibm,dynamic-memory-v2": This property replaces the "ibm,dynamic-memory"
> node representation within the "ibm,dynamic-reconfiguration-memory"
> property.  This element format is intended to provide a more compact
> representation of memory, especially, for systems with massive amounts
> of RAM.
>
> "ibm,architecture.vec": Bit flags are added to this data structure
> by the front end processor to inform the kernel as to whether to expect
> the changes to one or both of the device tree structures "ibm,drc-info"
> and "ibm,dynamic-memory-v2".
>
> The new element structures, "ibm,dynamic-memory-v2" and "ibm,drc-info",
> should completely replace the previously used structures at execution.
>
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> ---

Documentation/devicetree/bindings ? or link to PAPR where it's specified?

--=20
Stewart Smith
OPAL Architect, IBM.
