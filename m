Return-Path: <jwboyer@gmail.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.189])
	by ozlabs.org (Postfix) with ESMTP id 6E725DDF76
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Sep 2008 02:39:16 +1000 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so202970rnf.16
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Sep 2008 09:39:14 -0700 (PDT)
Date: Fri, 19 Sep 2008 12:38:19 -0400
From: Josh Boyer <jwboyer@gmail.com>
To: =?us-ascii?B?PT9JU08tODg1OS0xP1E/Uz1FOWJhc3RpZW5fQ2hyPUU5dGllbl8=?=
	<sebastie?==?ISO-8859-1?Q?n.chretien.enseirb@gmail.com>,
	?=@yoda.jdub.homelinux.org
Subject: Re: ioremap and vmalloc
Message-ID: <20080919163819.GB4492@yoda.jdub.homelinux.org>
References: <319b0ac50809190415g6d132058l9bb8521046502eab@mail.gmail.com>
	<20080919134933.GA7849@secretlab.ca> <48D3D47E.5050200@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48D3D47E.5050200@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 19, 2008 at 06:34:06PM +0200, =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien_ wrote:
> The first is ioremap(0x20000000,0x10000000);
> The second is ioremap(0x80000000,0x10000000);
> Is it too long

The error message you are getting should have been a very strong hint that
the answer is "yes."

josh
