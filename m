Return-Path: <prashantsmailcenter@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
 [209.85.215.170]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 6F724B7255
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2011 16:03:42 +1100 (EST)
Received: by eyg7 with SMTP id 7so3164059eyg.15
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 21:03:37 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 18 Nov 2011 10:33:37 +0530
Message-ID: <CAD6p20dmksH7YEjijdqLRG06aigaKTpzLPdoL0SCNGD3Ji9d2A@mail.gmail.com>
Subject: ibm_newemac tx problem with jumbo frame enabled
From: Prashant Bhole <prashantsmailcenter@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,
I have been facing problem with ibm_newemac driver (v3.54).
The board gets disconnected and can not be pinged in between
some heavy network traffic. In my case I am running IOmeter
"All-in-One" 8 threads on the iSCSI target. MTU is 4088.

I found that after executing emac_full_tx_reset(), the board can
be pinged again. Again after some heavy traffic of 5-6 seconds,
traffic stops. This can be repeated after full tx reset.

Is this a known issue? what could cause this?
Any pointers would be greatly appreciated.


-
Prashant
