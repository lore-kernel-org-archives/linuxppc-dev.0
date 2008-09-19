Return-Path: <jwboyer@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.27])
	by ozlabs.org (Postfix) with ESMTP id 76E73DE050
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Sep 2008 02:59:30 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so53692qwb.15
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Sep 2008 09:59:29 -0700 (PDT)
Date: Fri, 19 Sep 2008 12:58:33 -0400
From: Josh Boyer <jwboyer@gmail.com>
To: chretien@enseirb.fr
Subject: Re: ioremap and vmalloc
Message-ID: <20080919165833.GD4492@yoda.jdub.homelinux.org>
References: <319b0ac50809190415g6d132058l9bb8521046502eab@mail.gmail.com>
	<20080919134933.GA7849@secretlab.ca> <48D3D47E.5050200@gmail.com>
	<20080919163819.GB4492@yoda.jdub.homelinux.org>
	<48D3D70D.3060404@enseirb.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48D3D70D.3060404@enseirb.fr>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 19, 2008 at 06:45:01PM +0200, =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien_ wrote:
> if I write :
> ioremap(0x20000000,0x40000) and ioremap(0x20000000,0x50000)
>
> Will it crash ?

I have no idea.  You haven't given us enough information to really answer
that.

Basic information needed would be: 

1) What board/chip
2) What kernel version
3) What are you actually trying to do
4) What driver are you using
5) If you are writing your own, where is the code for it

etc.

josh
