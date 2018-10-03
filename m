Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1B8C64EBC
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 06:31:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C92B20835
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 06:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ICS+yHQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C92B20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Q5lb3SqhzF3JH
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 16:31:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ICS+yHQk";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Q5X26SpkzF3Bb
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 16:21:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="ICS+yHQk"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42Q5X25r2DzB4MQ; Wed,  3 Oct 2018 16:21:54 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42Q5X25Srdz9vZs; Wed,  3 Oct 2018 16:21:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1538547714;
 bh=R2quBuLkPwviUaaodvzsatat8R4m2sw753O/MqtcJRI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ICS+yHQkkT9khnPFFr1HtRtRoWT0RkOiesZMHNFmSQEwSteCfLXexIIyRMxX3hJYc
 6LGhFPnodD7B7xcB76tcaGSMvPkoO+8PL4BycnwScq/t5l7tNEzunQfYmmWx4poM5k
 tNpXaHDhR90ihTw7ejzhhgrbNosOTxVlPG61bgtw=
Date: Wed, 3 Oct 2018 15:56:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v3 23/33] KVM: PPC: Book3S HV: Introduce rmap to track
 nested guest mappings
Message-ID: <20181003055637.GS1886@umbus.fritz.box>
References: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
 <1538479892-14835-24-git-send-email-paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lt3WynA+XK9Fj6D4"
Content-Disposition: inline
In-Reply-To: <1538479892-14835-24-git-send-email-paulus@ozlabs.org>
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
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--lt3WynA+XK9Fj6D4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 02, 2018 at 09:31:22PM +1000, Paul Mackerras wrote:
> From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>=20
> When a host (L0) page which is mapped into a (L1) guest is in turn
> mapped through to a nested (L2) guest we keep a reverse mapping (rmap)
> so that these mappings can be retrieved later.
>=20
> Whenever we create an entry in a shadow_pgtable for a nested guest we
> create a corresponding rmap entry and add it to the list for the
> L1 guest memslot at the index of the L1 guest page it maps. This means
> at the L1 guest memslot we end up with lists of rmaps.
>=20
> When we are notified of a host page being invalidated which has been
> mapped through to a (L1) guest, we can then walk the rmap list for that
> guest page, and find and invalidate all of the corresponding
> shadow_pgtable entries.
>=20
> In order to reduce memory consumption, we compress the information for
> each rmap entry down to 52 bits -- 12 bits for the LPID and 40 bits
> for the guest real page frame number -- which will fit in a single
> unsigned long.  To avoid a scenario where a guest can trigger
> unbounded memory allocations, we scan the list when adding an entry to
> see if there is already an entry with the contents we need.  This can
> occur, because we don't ever remove entries from the middle of a list.
>=20
> A struct nested guest rmap is a list pointer and an rmap entry;
> ----------------
> | next pointer |
> ----------------
> | rmap entry   |
> ----------------
>=20
> Thus the rmap pointer for each guest frame number in the memslot can be
> either NULL, a single entry, or a pointer to a list of nested rmap entrie=
s.
>=20
> gfn	 memslot rmap array
>  	-------------------------
>  0	| NULL			|	(no rmap entry)
>  	-------------------------
>  1	| single rmap entry	|	(rmap entry with low bit set)
>  	-------------------------
>  2	| list head pointer	|	(list of rmap entries)
>  	-------------------------
>=20
> The final entry always has the lowest bit set and is stored in the next
> pointer of the last list entry, or as a single rmap entry.
> With a list of rmap entries looking like;
>=20
> -----------------	-----------------	-------------------------
> | list head ptr	| ----> | next pointer	| ---->	| single rmap entry	|
> -----------------	-----------------	-------------------------
> 			| rmap entry	|	| rmap entry		|
> 			-----------------	-------------------------
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> ---
>  arch/powerpc/include/asm/kvm_book3s.h    |   3 +
>  arch/powerpc/include/asm/kvm_book3s_64.h |  70 ++++++++++++++++-
>  arch/powerpc/kvm/book3s_64_mmu_radix.c   |  44 +++++++----
>  arch/powerpc/kvm/book3s_hv.c             |   1 +
>  arch/powerpc/kvm/book3s_hv_nested.c      | 130 +++++++++++++++++++++++++=
+++++-
>  5 files changed, 233 insertions(+), 15 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include=
/asm/kvm_book3s.h
> index d983778..1d2286d 100644
> --- a/arch/powerpc/include/asm/kvm_book3s.h
> +++ b/arch/powerpc/include/asm/kvm_book3s.h
> @@ -196,6 +196,9 @@ extern int kvmppc_mmu_radix_translate_table(struct kv=
m_vcpu *vcpu, gva_t eaddr,
>  			int table_index, u64 *pte_ret_p);
>  extern int kvmppc_mmu_radix_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
>  			struct kvmppc_pte *gpte, bool data, bool iswrite);
> +extern void kvmppc_unmap_pte(struct kvm *kvm, pte_t *pte, unsigned long =
gpa,
> +			unsigned int shift, struct kvm_memory_slot *memslot,
> +			unsigned int lpid);
>  extern bool kvmppc_hv_handle_set_rc(struct kvm *kvm, pgd_t *pgtable,
>  				    bool writing, unsigned long gpa,
>  				    unsigned int lpid);
> diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/incl=
ude/asm/kvm_book3s_64.h
> index 5496152..38614f0 100644
> --- a/arch/powerpc/include/asm/kvm_book3s_64.h
> +++ b/arch/powerpc/include/asm/kvm_book3s_64.h
> @@ -53,6 +53,66 @@ struct kvm_nested_guest {
>  	struct kvm_nested_guest *next;
>  };
> =20
> +/*
> + * We define a nested rmap entry as a single 64-bit quantity
> + * 0xFFF0000000000000	12-bit lpid field
> + * 0x000FFFFFFFFFF000	40-bit guest physical address field

I thought we could potentially support guests with >1TiB of RAM..?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lt3WynA+XK9Fj6D4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu0WhMACgkQbDjKyiDZ
s5LWZQ//SUMAcmDQAUvQbPU02BfHcWI/mSQ/kY/PDDARPgMLRfCUhmPVoQ33fwUp
zKSOPthpfVFzFRtwMb6DZPZFQJUsdPOL3i9qNUz0h+upAouDYky5mVM+LKX6jW8B
JbjRYwWJJNuGnyAbPVTSb8IdxcyXWumv3YZxfVG3faAn9QkoaUn1kjrSwuAUy2Xy
lESymZKskwpONuikPhjaLgK/R3QCfWMu6iLSVCVx/H/7R14lPVEY3JMCYnTnNDFe
bKj8MOCP8TnFXkwd2BoVzTSaFEbkW3a1MQfjQjiuTKEq1+ZnzYkbm0nicF7OL0Cj
+oB3h++YSQpVo9r8NdrLXBPLhJj6aEEvJlGOFPbVdqdES3N+UydTfigfvGAMT1fR
Sg8BgOhzxN9zQ2d2zF6WD4mXXTVn4ZcyFsrLfQHmytPjMcaw0En4nPahyBtf7Bpg
lgkIH49yU9QhCGCe1YWS4XOXEqcuQM7pU1k/9Vnqwm761PuxBAl1BHJznNbb8Nxe
RWozROGreURj/tIIt9d+WNAeZUZ6vHq83Sm9TCBlMiVYdcb2ACBlU9oszA3KLRDe
lRSfXssSsQE6s/6lEMvCHFxYv8xSm4JjttLBkSUcceSYrZnLGTNZaBI+siUIPv27
LzPkr+/0YZPXjwDgMczm7dY1MkLrjsTlEqxAc3Wivotje5vd/RI=
=bwUU
-----END PGP SIGNATURE-----

--lt3WynA+XK9Fj6D4--
