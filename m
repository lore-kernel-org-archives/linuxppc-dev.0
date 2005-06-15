Return-Path: <Martin.Krause@tqs.de>
Received: from mail.tqs.de (mail.tqs.de [213.68.230.225])
	by ozlabs.org (Postfix) with ESMTP id 3C9CD679E6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 01:38:37 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 15 Jun 2005 17:12:14 +0200
Message-ID: <47F3F98010FF784EBEE6526EAAB078D119EC27@tq-mailsrv.tq-net.de>
From: "Martin Krause" <Martin.Krause@tqs.de>
To: "Schaefer-Hutter, Peter" <Peter.Schaefer-Hutter@tfk-racoms.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: AW: 2.4.26 and MPC885 context switching time
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Peter,

linuxppc-embedded-bounces@ozlabs.org wrote on :
> i'm evaluating IPC on the MPC885ADS and discovered
> that the context switching times seem to be quite
> disappointing (up to 1ms). As we need to do a lot
..=20
> Or is this the expected context switching time for
> CPU @ 100 MHz (RAM @ 50 MHz)? Suggestions for a
> benchmark program?

Denx has done some detailed performance measurements=20
(including context switching). You could find the report=20
here: http://www.denx.de/twiki/bin/view/Know/Linux24vs26.
Hope that is of some help.

Regards,
Martin
