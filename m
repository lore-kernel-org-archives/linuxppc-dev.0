Return-Path: <timur.tabi@calxeda.com>
Received: from smtp141.iad.emailsrvr.com (smtp141.iad.emailsrvr.com
 [207.97.245.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6CDFC2C0329
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2013 23:46:34 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by smtp24.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 1990C1A04F8
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2013 07:36:58 -0500 (EST)
Received: by smtp24.relay.iad1a.emailsrvr.com (Authenticated sender:
 timur.tabi-AT-calxeda.com) with ESMTPSA id C36561A0553
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2013 07:36:57 -0500 (EST)
Received: by mail-la0-f49.google.com with SMTP id fs13so22582lab.22
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2013 04:36:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1360660088-27464-1-git-send-email-sr@denx.de>
References: <1360660088-27464-1-git-send-email-sr@denx.de>
Date: Tue, 12 Feb 2013 06:36:55 -0600
Message-ID: <CAOZdJXUjxLd_Zds4e6faWuomG6_p6FE1YfnCDmQD-BvY86i2Mw@mail.gmail.com>
Subject: Re: [PATCH v2] net: fec_mpc52xx: Read MAC address from device-tree
From: Timur Tabi <timur.tabi@calxeda.com>
To: Stefan Roese <sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: netdev@vger.kernel.org, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 12, 2013 at 3:08 AM, Stefan Roese <sr@denx.de> wrote:

> +        * First try to read MAC address from DT
> +        */
> +       p = of_get_property(np, "local-mac-address", NULL);

of_get_mac_address()
