Return-Path: <pku.leo@gmail.com>
Received: from mail-qy0-f175.google.com (mail-qy0-f175.google.com
	[209.85.221.175]) by ozlabs.org (Postfix) with ESMTP id AE23BB7D06
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Apr 2010 13:10:02 +1000 (EST)
Received: by qyk5 with SMTP id 5so7005933qyk.3
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Apr 2010 20:10:00 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <2628E3BC-6FC4-4D84-A228-03C6D955EB4F@kernel.crashing.org>
References: <1271403278-30091-1-git-send-email-leoli@freescale.com>
	<1271644834.14835.40.camel@concordia> <4BCBE133.3010407@freescale.com>
	<2628E3BC-6FC4-4D84-A228-03C6D955EB4F@kernel.crashing.org>
Date: Tue, 20 Apr 2010 11:10:00 +0800
Message-ID: <l2h2a27d3731004192010if95cf38ey42b6390fdaa2a1f5@mail.gmail.com>
Subject: Re: [PATCH 1/4] fsl_msi: fix the conflict of virt_msir's chip_data
From: Li Yang <leoli@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Zhao Chenhui <b26998@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 19, 2010 at 8:19 PM, Kumar Gala <galak@kernel.crashing.org> wro=
te:
>
> On Apr 18, 2010, at 11:50 PM, Li Yang wrote:
>
>> On 4/19/2010 10:40 AM, Michael Ellerman wrote:
>>> On Fri, 2010-04-16 at 15:34 +0800, Li Yang wrote:
>>>
>>>> From: Zhao Chenhui<b26998@freescale.com>
>>>>
>>>> In fsl_of_msi_probe(), the virt_msir's chip_data have been stored
>>>> the pointer to struct mpic. We add a struct fsl_msi_cascade_data
>>>> to store the pointer to struct fsl_msi and msir_index. =C2=A0Otherwise=
,
>>>> the pointer to struct mpic will be over-written, and will cause
>>>> problem when calling eoi() of the irq.
>>>>
>>> I don't quite understand. Do you mean someone was overwriting
>>> handler_data somewhere?
>>>
>>
>> The patch at http://patchwork.ozlabs.org/patch/48794/ was overwriting th=
e chip_data. =C2=A0We move the newly added pointer to fsl_msi structure to =
the handler data.
>
> Let's fix that patch.

All right.  You can merge the two patches if you like it that way.

Thanks.
Leo
