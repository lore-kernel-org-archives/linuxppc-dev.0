Return-Path: <typedef@eircom.net>
Received: from eurodubx.europlex.local (mail.europlex.ie [83.141.76.10])
	by ozlabs.org (Postfix) with ESMTP id 40E56679F5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 May 2005 19:58:38 +1000 (EST)
Message-ID: <4434E283.3000201@eircom.net>
From: Bryan O'Donoghue <typedef@eircom.net>
MIME-Version: 1.0
To: Pantelis Antoniou <panto@intracom.gr>
References: <20050517081558.74BA0C1512@atlas.denx.de>
	<4289A635.5000509@intracom.gr>
In-Reply-To: <4289A635.5000509@intracom.gr>
Content-Type: text/plain; charset=windows-1252
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC885 - USB HCI drivers.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>
Date: Tue, 17 May 2005 09:58:40 -0000

Pantelis Antoniou wrote:

> Well I have USB host drivers for both 8xx & 82xx working.

Speaking of which... would it not be a good idea, to get these comitted
to the 2.6 tree... at some stage ... at least to stop people
periodically posting to this list... saying "Dear all have spent 2
months, writing code for m8xx_hci drivers", when it's a needless
replication of effort ?

> However I use them connected to a specific peripheral
> so I don't know how well they fare when used as a PC
> style USB host controller.

Also, one easy way to find out, how well or badly said code performs, in
hetrogenous environments, is to... suck it and see.

As I was attempting to intimate above, I'm sure there'd be a legion of
eager people to debug, modify and recode such drivers, if there lived in
an obvious place... in the 2.6 tree.

Just my €0.02.

--

Best,
Bryan
