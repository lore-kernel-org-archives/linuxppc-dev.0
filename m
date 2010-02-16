Return-Path: <glikely@secretlab.ca>
Received: from mail-qy0-f189.google.com (mail-qy0-f189.google.com
	[209.85.221.189]) by ozlabs.org (Postfix) with ESMTP id 7C1B7B7D71
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Feb 2010 05:11:48 +1100 (EST)
Received: by qyk27 with SMTP id 27so4079677qyk.3
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2010 10:11:47 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1265377377-29327-11-git-send-email-agust@denx.de>
References: <1265377377-29327-1-git-send-email-agust@denx.de>
	<1265377377-29327-11-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 16 Feb 2010 11:11:26 -0700
Message-ID: <fa686aa41002161011r29f5323clcbb1d89a9df6614@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] powerpc/mpc5121: update mpc5121ads DTS
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, dzu@denx.de,
	Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 5, 2010 at 6:42 AM, Anatolij Gustschin <agust@denx.de> wrote:
> Collects several changes needed after applying
> previous mpc5121 platform and driver patches:

I'll merge this one, but...

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0display@2100 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-diu", "fsl-diu";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-diu", "fsl,diu";

I want to see the "fsl,diu" value removed.  It is meaningless (the
8xxx and 5121 dius are similar, but they are not identical), and the
driver should bind against "fsl,mpc5121-diu" directly.  Can you please
send a followup patch to fix this?

Thanks,
g.
