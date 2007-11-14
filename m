Return-Path: <robertlazarski@gmail.com>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.179])
	by ozlabs.org (Postfix) with ESMTP id 0E784DDE03
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Nov 2007 06:18:32 +1100 (EST)
Received: by el-out-1112.google.com with SMTP id r27so158725ele
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Nov 2007 11:18:31 -0800 (PST)
Message-ID: <f87675ee0711141118h3281b79dpaa49c6da7d57d891@mail.gmail.com>
Date: Wed, 14 Nov 2007 14:18:30 -0500
From: "robert lazarski" <robertlazarski@gmail.com>
Subject: Re: 85xx Device tree problems: e0024520:02 not found
Cc: linuxppc-embedded@ozlabs.org
In-Reply-To: <473A0A1B.3020302@anagramm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f87675ee0711131217q6bb54e06q74f7d16e79b94f19@mail.gmail.com>
	<473A0A1B.3020302@anagramm.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Nov 13, 2007 3:33 PM, Clemens Koller <clemens.koller@anagramm.de> wrote:
> robert lazarski schrieb:
>  > Hi all,
>  >
>  > I'm trying to bring up a new 8548 board on 2.6.23.1 . When booting,
>  > Some times I can get as far mounting over nfs. However, it gets stuck
>  > here:
>  >
>  > NET: Registered protocol family 1
>  > NET: Registered protocol family 17
>  > e0024520:02 not found
>  > eth2: Could not attach to PHY
>  > IP-Config: Failed to open eth2
>  > IP-Config: Device `eth2' not found.
>
> As already written in the u-boot-users list,
> you could give the pauilis.git tree a try.
>
> There have been recently (last month) several
> PHY related changes. 2.6.23.1 seems to be too
> "old".
>

I'm now running pauilis.git and 2.6.24rc2, along with a new custom
board. I still can't attach to the phy though. I know the phy works
because it works fine in u-boot. Clemens, IIRC you are using the
88e1111 - is that with the gianfar driver? I'm having problems getting
soft reboot to work with pauilis.git from some reason so debugging is
slow going - might someone have some hints?

Thanks,
Robert
