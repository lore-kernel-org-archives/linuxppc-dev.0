Return-Path: <patrick.huesmann@gmail.com>
Received: from uproxy.gmail.com (uproxy.gmail.com [66.249.92.206])
	by ozlabs.org (Postfix) with ESMTP id 29E55689AC
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Jan 2006 20:46:34 +1100 (EST)
Received: by uproxy.gmail.com with SMTP id h2so910909ugf
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Jan 2006 01:46:32 -0800 (PST)
Message-ID: <93579fec0601170146h5363e65bt410276b8b696588f@mail.gmail.com>
Date: Tue, 17 Jan 2006 10:46:32 +0100
From: Patrick Huesmann <patrick.huesmann@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Virtex-4 TEMAC device driver available?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I'm using linux on several projects running on Virtex2Pro boards
utilizing a softcore MAC ("OPB EMAC"). Recently, we built a new board
based on the Virtex 4 FX and I noticed that its hardwired "TEMAC"
differs significantly from the "OPB EMAC" we used before.

Is there already a linux driver for this TEMAC available? I noticed
that several patches for basic Virtex-4 support have been posted to
this list, but I don't know what kernel these patches are based on, or
where I can download a development snapshot.

Unfortunately, the public rsync repository at source.mvista.com (where
I got the kernel for our Virtex2Pro based stuff from) seems to be
discontinued, and I don't see any PPC specific kernel stuff in the git
repositories there.

Thanks,
Patrick
