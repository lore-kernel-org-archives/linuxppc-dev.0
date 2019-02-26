Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C45C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 23:38:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85770218D0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 23:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="EXGUM2HH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85770218D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448Fck6LRmzDqMP
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 10:38:30 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448FZb0Jy0zDqL4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 10:36:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="EXGUM2HH"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 448FZZ3XVhz9s9y; Wed, 27 Feb 2019 10:36:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1551224198;
 bh=td0Myqjkda8XlZ0PuI6HW3nQBt57Fk8mgbxoc7+Yh7w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EXGUM2HHgszqu99Ze9jAvKSXkaFetJ4qblwF7xAiWDQ6uC81FNTxXE+1xiBBOgqX5
 L5hc8dIHxLfrO15bLKDBcKHEHg9Mm9f3dd2sD34nhpoXSshclzrgCoL7wVJbWAvAW5
 wv0BEttz/WCcrOhGGZsBGXFlTJiHHX3J2Y5NE+L8=
Date: Wed, 27 Feb 2019 10:20:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v2 04/16] KVM: PPC: Book3S HV: XIVE: add a control to
 initialize a source
Message-ID: <20190226232033.GU6872@umbus.fritz.box>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-5-clg@kaod.org>
 <20190225021012.GH7668@umbus.fritz.box>
 <20190226042515.GB28015@blackberry>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lIC76ItX9S6XOZ/S"
Content-Disposition: inline
In-Reply-To: <20190226042515.GB28015@blackberry>
User-Agent: Mutt/1.11.3 (2019-02-01)
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--lIC76ItX9S6XOZ/S
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 26, 2019 at 03:25:15PM +1100, Paul Mackerras wrote:
> On Mon, Feb 25, 2019 at 01:10:12PM +1100, David Gibson wrote:
> > On Fri, Feb 22, 2019 at 12:28:28PM +0100, C=E9dric Le Goater wrote:
> > > +	/*
> > > +	 * If the source doesn't already have an IPI, allocate
> > > +	 * one and get the corresponding data
> > > +	 */
> > > +	if (!state->ipi_number) {
> > > +		state->ipi_number =3D xive_native_alloc_irq();
> > > +		if (state->ipi_number =3D=3D 0) {
> > > +			pr_err("Failed to allocate IRQ !\n");
> > > +			return -ENXIO;
> > > +		}
> > > +		xive_native_populate_irq_data(state->ipi_number,
> > > +					      &state->ipi_data);
> > > +		pr_debug("%s allocated hw_irq=3D0x%x for irq=3D0x%lx\n", __func__,
> > > +			 state->ipi_number, irq);
> > > +	}
> > > +
> > > +	arch_spin_lock(&sb->lock);
> >=20
> > Why the direct call to arch_spin_lock() rather than just spin_lock()?
>=20
> He's sharing data structures with the xics-on-xive code, and that code
> has a real-mode variant, and in real mode we don't want to risk
> invoking lockdep code.  Hence sb->lock is an arch_spinlock_t, and he
> has to use arch_spin_lock() on it.

Ah, right.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lIC76ItX9S6XOZ/S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx1ycEACgkQbDjKyiDZ
s5K9yQ//TxJ/OtHQ+JjZ1OENZvfGSQS0F8DT2GAPYWoH3vFizcDU/RTQrrXVVEC/
dTF9uNqs9zuk7SC26php82pL4S5xYCaI+/DeZOY5KJ70FUWmtGuKQV7a3eMAC/UA
dip35re9ojfN4ctsrgwGZiLD9TrPFH6LVERmyJhhGLN4ZJfC+OjmwPv5MEl/pJMu
tN9rdvnm82Jt8nzuJmCTYNBSzvGJ+wAi9ZLXgnfLHWvuo6wZuG6URJyt+hSwMS/o
LuhXz+/Q+mKlexrgFvS/lO3lwbkJ3MazisH0ihiBVa8HHlchiaslGbhU29weInN2
QLxSyz1PjRhcnf/AkqTGLF1VJqSxtEzARriFbzfTHNjSCSOFXW1w7h44Har7758n
UdFustPWr4Nh8khI4U2wTjUwuNrpLIlBv6KWGTebxxEBcdWB0fMOs1M7kIFNdAc9
/o34BN1iBupWPPfPksDcTbz6ff3HhfPQN8pq2XrF8i8sCtP2diRdJHRtlRaH0yPO
U8069EwRqP46xl8GqLqeRm2dlECZIR7yOjl3LKK4qFk4jmA9gXENeuuaakTMmsbM
CgEPxcLnpIYVZ7St7ORCvbOq0Rk7eh1eAXvlEZsDCAYm/X/a1cm/R2z8in3cUezi
aJacnJH6r5L1gW0XVLkix3RspjzZzJH29j2ItggWUs0jVm/Sp1M=
=n0wd
-----END PGP SIGNATURE-----

--lIC76ItX9S6XOZ/S--
