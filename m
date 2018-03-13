Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4012fz16TQzF08F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 04:59:22 +1100 (AEDT)
Date: Tue, 13 Mar 2018 18:59:16 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] rfi-flush: Make it possible to call
 setup_rfi_flush() again
Message-ID: <20180313185916.3e4a0ea6@kitsune.suse.cz>
In-Reply-To: <c7cadceb-1957-046e-8934-592baccca5b7@linux.vnet.ibm.com>
References: <1518644021-17037-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1518644021-17037-3-git-send-email-mauricfo@linux.vnet.ibm.com>
 <20180215081358.2f37cda4@naga.suse.cz>
 <b87d6261-c48d-6eab-e328-6988f628c949@linux.vnet.ibm.com>
 <87lgforngp.fsf@concordia.ellerman.id.au>
 <20180220180621.11265945@kitsune.suse.cz>
 <2bb5a110-3ea4-af5c-81fb-cf5350587dff@linux.vnet.ibm.com>
 <876069flhq.fsf@concordia.ellerman.id.au>
 <20180306135522.040707de@kitsune.suse.cz>
 <f11fdded-9d5e-d06f-b75e-d0a802b2005d@linux.vnet.ibm.com>
 <876060gq5s.fsf@concordia.ellerman.id.au>
 <c7cadceb-1957-046e-8934-592baccca5b7@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 13 Mar 2018 09:14:39 -0300
Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com> wrote:

> Hi Michael,
>=20
> On 03/13/2018 08:39 AM, Michael Ellerman wrote:
> >> I agree; the 'Using fallback displacement flush' message is
> >> misleading (is the system slower/fallback or not? =C3=94_o) =20
>=20
> > That message is actually just wrong.
> >=20
> > It still prints that even if enable=3Dfalse.
> >=20
> > So we should change all those messages, perhaps:
> >=20
> > 	pr_info("rfi-flush: fallback displacement flush
> > available\n"); pr_info("rfi-flush: ori type flush available\n");
> > 	pr_info("rfi-flush: mttrig type flush available\n"); =20
>=20
> Indeed.

Maybe it would make more sense to move the messages to the function
that actually patches in the instructions?

Thanks

Michal
