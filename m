Return-Path: <ppc.addon@gmail.com>
Received: from mail-pz0-f43.google.com (mail-pz0-f43.google.com
	[209.85.210.43]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 87ED9B6F75
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Oct 2011 22:35:37 +1100 (EST)
Received: by pzd13 with SMTP id 13so1140332pzd.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 04 Oct 2011 04:35:34 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 4 Oct 2011 13:35:33 +0200
Message-ID: <CABMX=Wz0uka4Z75TPge6ibntnEHHzgexcZOt==gQoahaedJU1Q@mail.gmail.com>
Subject: Re: [PATCH] libata: Convert LED disk trigger from IDE to libata
From: nello martuscielli <ppc.addon@gmail.com>
To: =?ISO-8859-1?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nico Macrionitis <acrux@cruxppc.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Jorg,

you submitted the patch slightly modified by Acrux (from CruxPPC) [1]
Anyway this patch is widely used by any ibook/powerbook owners with
great satisfaction.
I also use this patch from Jan 2011 and i'd like to see it upstreamed.

Btw, guess you should add:

Signed-off-by: Joseph Jezak <josejx@gentoo.org>
Acked-by: Nico Macrionitis <acrux@cruxppc.org>


cheers,
Nello

[1] http://forums.gentoo.org/viewtopic-p-6550023.html#6550023
