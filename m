Return-Path: <rdreier@cisco.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EAE71B7C05
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 29 Aug 2009 02:40:00 +1000 (EST)
Received: from sj-iport-1.cisco.com (sj-iport-1.cisco.com [171.71.176.70])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-1.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 57387DDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Aug 2009 02:40:00 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Joachim Fenkes <FENKES@de.ibm.com>
Subject: Re: [ewg] [PATCH] IB/ehca: Construct MAD redirect replies from
	request MAD
References: <200908261337.56128.fenkes@de.ibm.com>
	<f0e08f230908260815g70de3002pfd0b34f1b17abd6@mail.gmail.com>
	<OFF2257478.FF0FEABE-ONC125761F.00344884-C125761F.00358310@de.ibm.com>
	<f0e08f230908270631j3e159f3fgb0034eb41acdac7b@mail.gmail.com>
	<OFA25F14CC.CE7042E9-ONC1257620.00453C46-C1257620.00474D70@de.ibm.com>
Date: Fri, 28 Aug 2009 09:28:29 -0700
In-Reply-To: <OFA25F14CC.CE7042E9-ONC1257620.00453C46-C1257620.00474D70@de.ibm.com>
	(Joachim Fenkes's message of "Fri, 28 Aug 2009 14:58:49 +0200")
Message-ID: <adabplzsy1e.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hal Rosenstock <hnrose@comcast.net>, OF-EWG <ewg@lists.openfabrics.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	OF-General <general@lists.openfabrics.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>,
	Hal Rosenstock <hal.rosenstock@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


 > Given that you seem to like the rest of the code and Jason hasn't spoken 
 > up yet, I think we can have Roland merge this patch. Roland, what do you 
 > think?

I don't see any problem with the idea and this does sound like a step
forward, so I am planning on merging this (pending review).
