Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3E03565A.49119F4@synergymicro.com>
Date: Fri, 20 Dec 2002 09:41:46 -0800
From: Dave Wilhardt <wilhardt@synergymicro.com>
Reply-To: wilhardt@synergymicro.com
MIME-Version: 1.0
To: =?iso-8859-1?Q?=D3=DA=E6=BA?= <yuj@mail.ndsc.com.cn>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: use bdi on board with ppcbug
References: <200212200829.CAA05221@lists.linuxppc.org>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wouldn't it be the PowerPC reset address - 0xFFF00100?

ÓÚæº wrote:

> hi!
>   I want to debug the kernel on the motorola lopec p011 board with bdi tools.
> And the first thing I must solve is to let the ppcbug "go" under the bdi control.But  I don't know where the entry of ppcbug is,so I can't "go" the ppcbug.Has anybody know that?Or,the ppcbug can not be run under this circumstances?
>
>   Wait for your reply?
>   Thanks in advance!
>
>                                                                yujing
>                                                         yuj@mail.ndsc.com.cn
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
