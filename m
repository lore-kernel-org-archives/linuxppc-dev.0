MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Netconsole on 8260
Date: Fri, 2 Jul 2004 11:18:31 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DB1F@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -----Original Message-----
> From: Tom Rini [mailto:trini@kernel.crashing.org]
> You can change netconsole from module_init to
> late_initcall(), but I don't think you can convince upstream
> that this is the correct fix.

Thanks... That worked. I'll probably just keep that as a local change
here.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
