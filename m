Return-Path: <vitalywool@gmail.com>
Received: from mail-qw0-f42.google.com (mail-qw0-f42.google.com
	[209.85.216.42]) by ozlabs.org (Postfix) with ESMTP id C78C2B70CB
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Sep 2010 01:52:06 +1000 (EST)
Received: by qwi4 with SMTP id 4so22930qwi.15
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Sep 2010 08:52:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <70810686-1EB6-4AD9-A89B-C2A8BA6AC30D@freescale.com>
References: <1284764008-19469-1-git-send-email-timur@freescale.com>
	<AANLkTikmfd=2N3GE1zpTqQ59583EEe1PDXggwHBUAj_5@mail.gmail.com>
	<AANLkTinidrifo3ry7o=DPKF96f3o4+_2zt7rsn=Zvh9D@mail.gmail.com>
	<1284779678.30449.108.camel@pasglop>
	<AC849F1A-BC8A-4705-90E0-26991FAE6EED@freescale.com>
	<70810686-1EB6-4AD9-A89B-C2A8BA6AC30D@freescale.com>
Date: Sat, 18 Sep 2010 17:52:04 +0200
Message-ID: <AANLkTikqTaOQDTYQXWp4PuYRhWkXK8uy5+iT-AvxW+91@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc: export ppc_tb_freq so that modules can
	reference it
From: Vitaly Wool <vitalywool@gmail.com>
To: Kumar Gala <kumar.gala@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Tabi Timur-B04825 <B04825@freescale.com>,
	linux-watchdog@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Sep 18, 2010 at 5:34 PM, Kumar Gala <kumar.gala@freescale.com> wrot=
e:

> I don't think either of these should be EXPORT_SYMBOL_GPL. =A0Why shouldn=
't a binary module be allowed to know these frequencies? =A0My view is why =
preclude anyone from using this how they want. =A0If they want to live in t=
he gray area so be it. =A0Who am I to say they shouldn't have that choice.

W00t, binary modules again... No, please. No binary modules in kernelspace.

Thanks,
   Vitaly
