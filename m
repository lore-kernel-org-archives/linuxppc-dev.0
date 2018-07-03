Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KbJT75Z6zF1QL
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 17:26:01 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>, Bharat Bhushan
 <bharat.bhushan@nxp.com>
Cc: Diana Madalina Craciun <diana.craciun@nxp.com>,
 "oss\@buserror.net" <oss@buserror.net>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Leo Li <leoyang.li@nxp.com>
Subject: Re: [PATCH v2 3/3] powerpc/fsl: Implement cpu_show_spectre_v1/v2 for
 NXP PowerPC Book3E
In-Reply-To: <20180612120737.31efff1c@naga.suse.cz>
References: <1528721608-15443-1-git-send-email-diana.craciun@nxp.com>
 <1528721608-15443-4-git-send-email-diana.craciun@nxp.com>
 <AM5PR0401MB2545BC30FB194E4D4E42ADA89A7F0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
 <20180612120737.31efff1c@naga.suse.cz>
Date: Tue, 03 Jul 2018 17:26:01 +1000
Message-ID: <87va9wg4qe.fsf@concordia.ellerman.id.au>
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

Michal Such=C3=A1nek <msuchanek@suse.de> writes:
> On Tue, 12 Jun 2018 02:59:11 +0000
> Bharat Bhushan <bharat.bhushan@nxp.com> wrote:
>
>> Hi Diana,
>>=20
>> > -----Original Message-----
>> > From: Diana Craciun [mailto:diana.craciun@nxp.com]
>> > Sent: Monday, June 11, 2018 6:23 PM
>> > To: linuxppc-dev@lists.ozlabs.org
>> > Cc: mpe@ellerman.id.au; oss@buserror.net; Leo Li
>> > <leoyang.li@nxp.com>; Bharat Bhushan <bharat.bhushan@nxp.com>;
>> > Diana Madalina Craciun <diana.craciun@nxp.com>
>> > Subject: [PATCH v2 3/3] powerpc/fsl: Implement
>> > cpu_show_spectre_v1/v2 for NXP PowerPC Book3E=20=20
>>=20
>> Please add some description
>
> To me the subject is self-explanatory. It implements a kernel interface
> that was already described elsewhere.
>
> What are you missing here?

It should at least explain why it's reimplementing a function that
already exists for powerpc. ie. Why can't the existing version be used?

cheers
