Return-Path: <tmarri@apm.com>
Received: from exprod5og114.obsmtp.com (exprod5og114.obsmtp.com [64.18.0.28])
	by ozlabs.org (Postfix) with SMTP id 84F5EB6F8D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jun 2011 13:57:03 +1000 (EST)
Received: by pxj25 with SMTP id 25so2294246pxj.9
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 31 May 2011 20:57:00 -0700 (PDT)
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
In-Reply-To: <1306208412.7481.214.camel@pasglop>
MIME-Version: 1.0
Date: Tue, 31 May 2011 14:18:50 -0700
Message-ID: <3c4c153ded9e631dd75fcad55c88686b@mail.gmail.com>
Subject: RE: [PATCH 0/1] ppc4xx: Fix PCIe scanning for the 460SX
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Mackerras <paulus@samba.org>, Ayman El-Khashab <ayman@elkhashab.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The interesting question of course is whether that 460SX stuff is the
same as what we're using internally :-)
[marri] Sometimes open-source and internal releases may not be the same
Because of open-source standards.

Can we fix that ?
[marri] Sure I will take a look at it.
