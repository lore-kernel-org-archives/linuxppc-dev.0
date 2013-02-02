Return-Path: <timur.tabi@calxeda.com>
Received: from smtp151.iad.emailsrvr.com (smtp151.iad.emailsrvr.com
 [207.97.245.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3A65B2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Feb 2013 07:24:13 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by smtp55.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id CF3062E056B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Feb 2013 15:24:09 -0500 (EST)
Received: by smtp55.relay.iad1a.emailsrvr.com (Authenticated sender:
 timur.tabi-AT-calxeda.com) with ESMTPSA id 8443D2E0572
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Feb 2013 15:24:09 -0500 (EST)
Received: by mail-lb0-f169.google.com with SMTP id m4so5645485lbo.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 02 Feb 2013 12:24:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <510D6819.7050002@prodrive.nl>
References: <1359765063.23561.14@snotra>
	<510D6819.7050002@prodrive.nl>
Date: Sat, 2 Feb 2013 14:24:08 -0600
Message-ID: <CAOZdJXWMyRBMPA1YVDMGNBNgzc_GLLoQWUt7uFw8wx1X-jFEDw@mail.gmail.com>
Subject: Re: [PATCH 1/1] powerpc/85xx: Board support for ppa8548
From: Timur Tabi <timur.tabi@calxeda.com>
To: Stef van Os <stef.van.os@prodrive.nl>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Feb 2, 2013 at 1:25 PM, Stef van Os <stef.van.os@prodrive.nl> wrote:

>> I guess the reason you're not using fsl/mpc8548si-post.dtsi is that you
>> don't want PCI.  Maybe PCI and srio should be moved out of that file, or
>> ifdeffed if 85xx ever ends up using the preprocessor for its device trees.
>>
> I went with timur's solution, patch v2 uses mpc8548si-post.dtsi and
> mpc8548si-pre.dtsi again, disabling everything that is not on the board.

FYI, someone posted some patches for dtc a couple months ago that
added an option to strip out disabled nodes when compiling the dts,
but those patches were rejected.  In your case, those patches could
significantly reduce the size of the compiled dtb.
