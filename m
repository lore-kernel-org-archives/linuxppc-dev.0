Return-Path: <tmarri@apm.com>
Received: from exprod5og110.obsmtp.com (exprod5og110.obsmtp.com [64.18.0.20])
	by ozlabs.org (Postfix) with SMTP id DEB5DB7188
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jun 2011 13:57:08 +1000 (EST)
Received: by pxi16 with SMTP id 16so3087367pxi.32
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 31 May 2011 20:57:06 -0700 (PDT)
From: Tirumala Marri <tmarri@apm.com>
References: <1302286930-9988-1-git-send-email-ayman@elkhashab.com>
	<1302306484.2458.64.camel@pasglop>
	<178c7df4696bacdd1510bacae143222a@mail.gmail.com>
	<20110429170240.GA21384@crust.elkhashab.com>
	<1304109476.2513.243.camel@pasglop>
	<1304487166.2513.351.camel@pasglop>
	<BANLkTi=BaYhw92wYHp9rPvz1yq2H1p0G9w@mail.gmail.com>
	<20110509160935.GA14965@crust.elkhashab.com>
	<6a09a426f126fb315b773fc207d68eb9@mail.gmail.com>
	<1306208412.7481.214.camel@pasglop>
	<20110527165108.GA1752@crust.elkhashab.com>
In-Reply-To: <20110527165108.GA1752@crust.elkhashab.com>
MIME-Version: 1.0
Date: Tue, 31 May 2011 14:27:19 -0700
Message-ID: <fa765cbed63d89c50a79b34f25dc9f5c@mail.gmail.com>
Subject: RE: [PATCH 0/1] ppc4xx: Fix PCIe scanning for the 460SX
To: Ayman El-Khashab <ayman@elkhashab.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Not sure how I would know --  But with my eiger kit, I got a
cd from amcc that had a patched 2.6.30 or something kernel
in it to support the 460SX.  The pci code was basically
subverted by adding a "port->link=1" at the very end of the
link check to always force it to succeed.  However this code
never appeared in the public git repositories, so I am not
sure how the 460SX functioned (if it ever did) since the
link check that is in there now can't work on that SOC.


[marri]I don't know what PCI-E devices you use. We use E1000
As a device for testing. Link-up was working before the submission.
There were some changes happened afterwards to the common code
Which seems to affected all 4xx devices. I will try latest code
On our other SoCs.


I took care of that in my patch.  Basically it let the
system go to gen-2 speeds and negotiate down.
[marri] Great thx.
