Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135C2C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 05:35:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 719F02084D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 05:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nxMXSlSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 719F02084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RJPW14mMzF3Qm
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 15:35:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nxMXSlSF";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RHVL00pwzF3Km
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 14:54:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="nxMXSlSF"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42RHVK6TXjz9s7W; Fri,  5 Oct 2018 14:54:33 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42RHVK5whQz9s8J; Fri,  5 Oct 2018 14:54:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1538715273;
 bh=9m1rW+l1AXTpvft5hPZAMIiUzu4IQvMAP/iRlKhuts0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nxMXSlSFtNNsWi7n40hhNXRXmpNQTigLLYInLyFRNwMM7USvAMazfOOQFjLokGgOx
 qkivg0GgYy8vrlOuSlGqm2IY69+wbmMAbNSId8VWOJm+7Pv481u1jfcj5eHkIF0hro
 7KaKeZF5MfrzHsLJim99rZoU9qAzZ859nBZir08k=
Date: Fri, 5 Oct 2018 14:54:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v4 25/32] KVM: PPC: Book3S HV: Invalidate TLB when nested
 vcpu moves physical cpu
Message-ID: <20181005045428.GO7004@umbus.fritz.box>
References: <1538654169-15602-1-git-send-email-paulus@ozlabs.org>
 <1538654169-15602-26-git-send-email-paulus@ozlabs.org>
 <20181005040908.GK7004@umbus.fritz.box>
 <20181005042350.GA3309@fergus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ncX6roZrNNHXnAbh"
Content-Disposition: inline
In-Reply-To: <20181005042350.GA3309@fergus>
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


--ncX6roZrNNHXnAbh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 05, 2018 at 02:23:50PM +1000, Paul Mackerras wrote:
> On Fri, Oct 05, 2018 at 02:09:08PM +1000, David Gibson wrote:
> > On Thu, Oct 04, 2018 at 09:56:02PM +1000, Paul Mackerras wrote:
> > > From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > >=20
> > > This is only done at level 0, since only level 0 knows which physical
> > > CPU a vcpu is running on.  This does for nested guests what L0 already
> > > did for its own guests, which is to flush the TLB on a pCPU when it
> > > goes to run a vCPU there, and there is another vCPU in the same VM
> > > which previously ran on this pCPU and has now started to run on anoth=
er
> > > pCPU.  This is to handle the situation where the other vCPU touched
> > > a mapping, moved to another pCPU and did a tlbiel (local-only tlbie)
> > > on that new pCPU and thus left behind a stale TLB entry on this pCPU.
> > >=20
> > > This introduces a limit on the the vcpu_token values used in the
> > > H_ENTER_NESTED hcall -- they must now be less than NR_CPUS.
> >=20
> > This does make the vcpu tokens no longer entirely opaque to the L0.
> > It works for now, because the only L1 is Linux and we know basically
> > how it allocates those tokens.  Eventually we probably want some way
> > to either remove this restriction or to advertise the limit to the L1.
>=20
> Right, we could use something like a hash table and have it be
> basically just as efficient as the array when the set of IDs is dense
> while also handling arbitrary ID values.  (We'd have to make sure that
> L1 couldn't trigger unbounded memory consumption in L0, though.)

Another approach would be to sacifice some performance for L0
simplicity:  when an L1 vCPU changes pCPU, flush all the nested LPIDs
associated with that L1.  When an L2 vCPU changes L1 vCPU (and
therefore, indirectly pCPU), the L1 would be responsible for flushing
it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ncX6roZrNNHXnAbh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu27oIACgkQbDjKyiDZ
s5L8+BAAh6z7rZMIskDaORz3M6QfiSGixLnQ2d4KawQcWTkDhuITUaz667o6dnvg
11LDj1TcIAnTBcVZ17Fk9w4VI6WA5jYrtN4f6/mI+Az6U1QZLo3jyBbboFwy86Ag
2pbTRW5iuepHza03UMQV1MebTzZHp/Pds8+G90kep2CSsDyD+/g8naUIIN8ewFw+
fjqbM2bYTV10OXwPEbff2QkdE1tlb32XkR9qYeJJdBmN7/2xblFVm1spPVdsEI0R
l0XRSzDqKLGBmkuohxlNec2Bwmy9+hUnlF1dDM89FqqHFpj7lapW1dHSraViUekd
dVzK2+pemeM1vIotpHxYJJqIPaCuNQa8FuHBvwd/odjFHWv2tXu8jp2j57gh6+0L
8uFhUGsbEk8fdatKBYmO7uXARNTUpQMsO4tNVCHNNLYZ530IH5mnYA4aiHu6MCef
Xosu7Q/ldRqHMAJJZFcYVZ82bXtsAZqdXpUwy3q3t4Okkv6JPXT64q7hKyhPtCnM
Q5Iqd2pml84jOgT6bFTnBCY2Ycm6cnnCOA92JCbMcrvaejk7Hl1jnODv/tMMUzVL
MTJzH5QqGx+1paZ3tH5/V7K3ECHgKDlIOoVHFBOjpZT5hlwdPQeG1VMkNbthFQRh
/0B+PsSDc1qjpP02PO2Z8L9h413bbZrd3deJqWzKvyCqGJN6L1k=
=g2oH
-----END PGP SIGNATURE-----

--ncX6roZrNNHXnAbh--
