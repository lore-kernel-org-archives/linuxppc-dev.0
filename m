Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 97E082BD7B
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Sep 2004 20:10:06 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ken Moffat <ken@kenmoffat.uklinux.net>
In-Reply-To: <Pine.LNX.4.58.0409181032540.26433@ppg_penguin.kenmoffat.uklinux.net>
References: <Pine.LNX.4.58.0409172249520.23520@ppg_penguin.kenmoffat.uklinux.net>
	<1095465662.3660.3.camel@gaston>
	<Pine.LNX.4.58.0409181032540.26433@ppg_penguin.kenmoffat.uklinux.net>
Content-Type: text/plain
Message-Id: <1095502166.6545.5.camel@gaston>
Mime-Version: 1.0
Date: Sat, 18 Sep 2004 20:09:26 +1000
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Problem with 745x errata in 2.6.8
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> this usage of PVR was, so at the moment I haven't got a clue about what
> it contains or how to read it, but I guess that's where the values in
> the cpu_sec struct come from so I'll start looking.  Your comment on the
> northbridge sounds depressingly likely.

PVR is the Processor Version Register, indicates which CPU you have

Ben.
