Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 78231B8069
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Mar 2010 05:10:19 +1100 (EST)
Date: Thu, 11 Mar 2010 19:09:50 +0100
From: Anatolij Gustschin <agust@denx.de>
To: CTAG / =?UTF-8?B?TW9pc8OpcyBEb23DrW5ndWV6?= <moises.dominguez@ctag.com>
Subject: Re: Linus' kernel tree over ads5121-rev4
Message-ID: <20100311190950.2edddcd8@wker>
In-Reply-To: <DCD09CE7A7B046EA9AD832CD4648A26E@ctag>
References: <DCD09CE7A7B046EA9AD832CD4648A26E@ctag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Thu, 11 Mar 2010 13:53:45 +0100
CTAG / Mois=C3=A9s Dom=C3=ADnguez <moises.dominguez@ctag.com> wrote:

> Linux is uncompressed and starts right, but when DIU driver probe function
> is called (exactly when first framebuffer device is registered) linux
> restarts. This behaviour repeats indefinitely.
>=20
> (same behaviour with denx kernel tree).

DIU support patch hasn't been merged yet, you can either
disable DIU frame buffer driver or use the DIU patch [1].

> I am using .dts that comes in the Linus=E2=80=99kernel tree. Maybe this .=
dts board
> revision dependent?=20

DTS in 2.6.34-rc1 is ok for DIU if you use the patch. Note
that you need to rebase it as it depends on USB support patches
which haven't been merged yet.

DIU frame buffer support is work in progress, it hopefully will
be included in 2.6.35.

[1] http://patchwork.ozlabs.org/patch/44639/
