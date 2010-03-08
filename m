Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f228.google.com (mail-gx0-f228.google.com
	[209.85.217.228]) by ozlabs.org (Postfix) with ESMTP id 75B6BB7CF6
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Mar 2010 06:08:38 +1100 (EST)
Received: by gxk28 with SMTP id 28so5238872gxk.2
	for <linuxppc-dev@ozlabs.org>; Mon, 08 Mar 2010 11:08:37 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4B95458A.4000304@freemail.hu>
References: <4B934CCA.8030608@freemail.hu>
	<fa686aa41003080934q5d5bebabl7d582d1264da4dcd@mail.gmail.com>
	<4B95458A.4000304@freemail.hu>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 8 Mar 2010 12:08:17 -0700
Message-ID: <fa686aa41003081108v31e73660pa817863e5aa73653@mail.gmail.com>
Subject: Re: cross-compiling Linux for PowerPC e200 core?
To: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2010/3/8 N=E9meth M=E1rton <nm127@freemail.hu>:
> Grant Likely wrote:
>> 2010/3/6 N=E9meth M=E1rton <nm127@freemail.hu>:
>>> Hi,
>>>
>>> I'm trying to cross-compile Linux 2.6.33 for Freescale MPC5554 [1][2]. =
This
>>> microcontroller is based on the e200z6 core. I could build the cross-de=
velopment
>>> tools, but I could miss something because I get an error message when b=
uilding
>>> Linux for PowerPC e200 core. Here are the steps I used:
>>
>> I doubt you'll have much luck with the mpc5554. =A0Linux doesn't include
>> any support for the MPC5554, and I don't think anybody is working on
>> it. =A0Any of the mpc5554 systems I've see don't have enough ram to run
>> Linux well.
>
> I'm ready to work a bit more than just compiling the kernel and run it on=
 MPC5554.
> On my target system there is a possibility to use external RAM connected =
to the
> External Bus Interface, so I don't see this would be a problem in my case=
.
>
> However, I have not much experience running Linux on PowerPC environment.=
 Could
> you suggest a PowerPC port which would be a good starting point to make s=
upport
> for MPC5554?

I'd use the MPC5200 board support as a starting point
(arch/powerpc/platforms/52xx).  Create yourself a new directory for
this platform (arch/powerpc/platforms/55xx)

> As far as I could find out I'll need to create a device tree as documente=
d in
> the linux/Documentation/powerpc/booting-without-of.txt file.

Yes, you'll need to create a device tree file for the board.  Again,
start from an existing 5200 .dts file.  You won't need very much in it
to get started.  I'd be happy to help you get the structure right.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
