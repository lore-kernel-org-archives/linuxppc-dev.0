Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 80D1FB7BA8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Oct 2009 06:54:56 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id C427CC50CA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Oct 2009 20:54:47 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Micrel PHY KSZ8001 on MPC5200B FEC
References: <mailman.1186.1256651657.12812.linuxppc-dev@lists.ozlabs.org>
	<200910271549.n9RFn3ep028623@nti1.com>
In-Reply-To: <200910271549.n9RFn3ep028623@nti1.com>
MIME-Version: 1.0
Message-ID: <200910272054.47398.roman.fietze@telemotive.de>
Date: Tue, 27 Oct 2009 20:54:47 +0100
Content-Type: Text/Plain;
  charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Suvidh,

On Tuesday 27 October 2009 17:47:51 suvidh kankariya wrote:

> A driver for micrel phy exists in /drivers/net/phy/micrel.c. in
> 2.6.30.

Am I somewhat blind, or do you have access to other 2.6.30's than I
have?

I searched git.kernel.org, git.denx.de and git.secretlab.ca, but could
not find that file, neither in the current master, nor in older tags
somewhat related to "2.6.30", nor in any local clone in any version of
the 2.6 since "He" created the repos.


> If you are using older kernel you may want to copy it.

2.6.30 and 2.6.31 from DENX or kernel.org.


Roman

=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
