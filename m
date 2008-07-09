Return-Path: <dmitry.torokhov@gmail.com>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.183])
	by ozlabs.org (Postfix) with ESMTP id 8DC95DDE01
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 04:13:14 +1000 (EST)
Received: by el-out-1112.google.com with SMTP id o28so530348ele.3
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jul 2008 11:13:12 -0700 (PDT)
Message-ID: <d120d5000807091113n494485f2m66b22a0b9897b395@mail.gmail.com>
Date: Wed, 9 Jul 2008 14:13:12 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "John Linn" <John.Linn@xilinx.com>
Subject: Re: [PATCH] [V3] powerpc: Xilinx: PS2: Added new XPS PS2 driver
In-Reply-To: <20080709161408.55E0F4A006C@mail60-va3.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080707153850.4C83B128005C@mail53-wa4.bigfish.com>
	<878wwcsqcm.fsf@macbook.be.48ers.dk>
	<20080709161408.55E0F4A006C@mail60-va3.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, Sadanand Mutyala <sadanan@xilinx.com>,
	linux-input@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 9, 2008 at 12:14 PM, John Linn <John.Linn@xilinx.com> wrote:
> These look like good comments from Peter.
>
> Dmitry, how would you like to do this, would you prefer us to do an
> incremental patch from the existing patch (V3)?  Or a new V4 for the
> patch?
>

Incremental please. I already committed V3 to the 'next' branch and I
don't want to rebuild it unless the patch is completely broken so
incremental cleanup is the way to go.

Thanks.

-- 
Dmitry
