Message-ID: <3D647D91.2060508@dslextreme.com>
Date: Wed, 21 Aug 2002 22:58:41 -0700
From: akuster <akuster@dslextreme.com>
Reply-To: akuster@dslextreme.com
MIME-Version: 1.0
To: Eugene Surovegin <ebs@innocent.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Restructuring of ibm_ocp_enet driver
References: <5.1.0.14.2.20020820231900.03a9e008@pop.prodigy.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Eugene Surovegin wrote:
>
> David,
>
> At 09:36 PM 8/20/2002, you wrote:
>
>> The patch below make some first steps to restructuring the
>> ibm_ocp_enet driver .
>
>
> Wouldn't it be nice BEFORE another ibm_ocp_enet restructuring to fix bugs
> introduced in the previous one?
>
> Current version has broken rx ring buffer management and the typo in
> requesting IRQ for RXDE event.
>
> I send bug report and a fix (maybe not the most elegant one) to Armin two
> weeks ago. Nothing happened :(
>
 >
 > Thanks,
 >
 >  Eugene Surovegin <mailto:ebs@innocent.com>
 >

Eugene,

Patch should be in tomorrow.

Armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
