Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 28CEF67A79
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Jan 2005 06:10:52 +1100 (EST)
Date: Tue, 25 Jan 2005 11:10:47 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: annamaya <annamaya@yahoo.com>
Message-ID: <20050125191047.GA3818@gate.ebshome.net>
References: <20050125174913.42739.qmail@web53805.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050125174913.42739.qmail@web53805.mail.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Additional data/instruction BATs not initialized for MPC8280?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Jan 25, 2005 at 09:49:13AM -0800, annamaya wrote:
> I have read in the specs for the MPC8280 that it has a
> G2_LE core which has 4 additional data and instruction
> BATs. However, I dont see these BATS being cleared
> early in the kernel. I only see that the first 4 pairs
> are cleared using the mtspr instructions. But my
> kernel comes up just fine and everything seems to work
> OK. Dont we need to clear the other set of I/DBATS?
> What happens when we dont do this? Thanks in advance.

Additional BATs in G2_LE core must be explicitly enabled in HID2 (HBE 
bit), until then they "don't exist" :).

--
Eugene
