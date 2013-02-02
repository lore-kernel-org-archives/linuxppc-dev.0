Return-Path: <timur.tabi@calxeda.com>
Received: from smtp121.iad.emailsrvr.com (smtp121.iad.emailsrvr.com
 [207.97.245.121])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EC4822C008E
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Feb 2013 15:43:24 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by smtp32.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id B3DC2148225
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2013 23:34:45 -0500 (EST)
Received: by smtp32.relay.iad1a.emailsrvr.com (Authenticated sender:
 timur.tabi-AT-calxeda.com) with ESMTPSA id 6ABC514825E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2013 23:34:45 -0500 (EST)
Received: by mail-lb0-f172.google.com with SMTP id n8so5217831lbj.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Feb 2013 20:34:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1359765063.23561.14@snotra>
References: <1359733013-722-1-git-send-email-stef.van.os@prodrive.nl>
 <1359765063.23561.14@snotra>
Date: Fri, 1 Feb 2013 22:34:44 -0600
Message-ID: <CAOZdJXU6OFu1878s9rrNws3uqT_F7-GFS95ZJT5EZmw35=6hbQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] powerpc/85xx: Board support for ppa8548
From: Timur Tabi <timur.tabi@calxeda.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stef van Os <stef.van.os@prodrive.nl>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 1, 2013 at 6:31 PM, Scott Wood <scottwood@freescale.com> wrote:
>
> I guess the reason you're not using fsl/mpc8548si-post.dtsi is that you
> don't want PCI.  Maybe PCI and srio should be moved out of that file, or
> ifdeffed if 85xx ever ends up using the preprocessor for its device trees.

Wouldn't it be easier to add status="disabled" in this dts file?  I do
something similar with the LBC on the p1022rdk.

	board_lbc: lbc: localbus@ffe05000 {
		/* The P1022 RDK does not have any localbus devices */
		status = "disabled";
	};
