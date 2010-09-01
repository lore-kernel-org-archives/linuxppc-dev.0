Return-Path: <Jonathan.Haws@sdl.usu.edu>
Received: from echo.usurf.usu.edu (unknown [129.123.194.129])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "echo", Issuer "echo" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 4A14CB7155
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Sep 2010 08:08:07 +1000 (EST)
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-net@vger.kernel.org" <linux-net@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: Memory allocation modifications in ibm_newemac driver
Date: Wed, 1 Sep 2010 22:04:34 +0000
Message-ID: <5ABE8A5E96C0364CAF2B4DC1DEB7CEAC127A301B@Mercury.usurf.usu.edu>
References: <5ABE8A5E96C0364CAF2B4DC1DEB7CEAC127A2F09@Mercury.usurf.usu.edu>,
	<5ABE8A5E96C0364CAF2B4DC1DEB7CEAC127A2FBE@Mercury.usurf.usu.edu>
In-Reply-To: <5ABE8A5E96C0364CAF2B4DC1DEB7CEAC127A2FBE@Mercury.usurf.usu.edu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Okay, I think I have all the issues worked out and can now send and receive=
 any size packet without a hiccup.  I have tested this in our system setup =
as well with data being sent out to disk and did not see any problems there=
 either (since it only ever allocates a single page, never more).=0A=
=0A=
Is this something that may be wanted in the mainline?  I have not run full =
benchmarks, but I anticipate that my modified driver is slightly slower tha=
n the mainline driver because we keep track of an SKB ring, as well as a ri=
ng of pages and allocate both on each packet received.=0A=
=0A=
Thanks,=0A=
=0A=
Jonathan=0A=
=0A=
