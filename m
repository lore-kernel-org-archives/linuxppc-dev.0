Message-ID: <3D5803A3.7060708@dslextreme.com>
Date: Mon, 12 Aug 2002 11:51:15 -0700
From: akuster <akuster@dslextreme.com>
Reply-To: akuster@dslextreme.com
MIME-Version: 1.0
To: "David =?ISO-8859-1?Q?M=FCller?= (ELSOFT AG)" <d.mueller@elsoft.ch>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] Two little fixes for linuxppc_devel-2.4.19
References: <3D526BCF.5090809@elsoft.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Müller (ELSOFT AG) wrote:
> Hello
>
> The attached patch fixes the following issues:
>
>     - arch/ppc/kernel/ocp.c
>        missing export of "ocp_get_pm"
>
>
>     - drivers/net/ibm_ocp/ibm_ocp_enet.h
>        shifting of PM bits is done in wrong direction
>
>
> Dave
>

Great, looks good

Thanks David,

Armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
