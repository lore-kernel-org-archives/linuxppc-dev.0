Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 199BBDDDEA
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Dec 2008 20:34:12 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so552045yxg.39
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Dec 2008 01:34:10 -0800 (PST)
Message-ID: <fa686aa40812210134j7dfa2075j2de9129264777078@mail.gmail.com>
Date: Sun, 21 Dec 2008 02:34:10 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: Commits added to powerpc.git next and master branches
In-Reply-To: <1229851937.13001.57.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <18765.58426.49381.986612@cargo.ozlabs.ibm.com>
	<fa686aa40812210107o3d12d42q2e6b0265810f7b77@mail.gmail.com>
	<1229851937.13001.57.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Dec 21, 2008 at 2:32 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Sun, 2008-12-21 at 02:07 -0700, Grant Likely wrote:
>> Hey Paul,
>>
>> Top of your -next tree fails with a stack overflow on the MPC5200 when
>> attempting to mount an NFS rootfs (log below).  I haven't had a chance
>> to bisect yet, but I'm posting this in case someone has already seen
>> and solved this.
>
> >From the NIP & LR values, it looks like it could be my fault.
>
> MPC5200 is a 603 core right ?

Yes

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
