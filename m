Return-Path: <jwboyer@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id 7CD10DDE00
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Oct 2008 22:37:13 +1100 (EST)
Received: by gxk14 with SMTP id 14so10673806gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 08 Oct 2008 04:37:11 -0700 (PDT)
Date: Wed, 8 Oct 2008 07:35:47 -0400
From: Josh Boyer <jwboyer@gmail.com>
To: zhangyihere@gmail.com
Subject: Re: Could XUP be uesd as a SMP platform
Message-ID: <20081008113547.GA2293@yoda.jdub.homelinux.org>
References: <2c8360dd0810072349v4409f49ei7c0c45fc8dd4e798@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2c8360dd0810072349v4409f49ei7c0c45fc8dd4e798@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 08, 2008 at 02:49:14PM +0800, =?GB2312?B?ItXF6fMiIDx6aGFuZ3lpaGVyZUBnbWFpbC5jb20+?= wrote:
>Hi  all,
>
>I am working with a Xilinx Virtex II Pro evaluation board, which has two
>PowerPC 405 and I have ported linux 2.6.24 onto that board when there is one
>PPC405 configured.
>
>I'd like to use this board as a SMP platform. Is it feasible?

No.  The 405 cores are not designed with SMP in mind and it
will not work.

If the board has discrete memory for each CPU, you might be
able to run it in an AMP fashion.

josh
