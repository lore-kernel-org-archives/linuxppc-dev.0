Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f211.google.com (mail-gx0-f211.google.com
	[209.85.217.211])
	by bilbo.ozlabs.org (Postfix) with ESMTP id CD93CB6F34
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Aug 2009 16:08:06 +1000 (EST)
Received: by gxk7 with SMTP id 7so5410505gxk.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 25 Aug 2009 23:08:04 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20090825162314.10936.11028.stgit@localhost.localdomain>
References: <20090825162314.10936.11028.stgit@localhost.localdomain>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 26 Aug 2009 00:07:44 -0600
Message-ID: <fa686aa40908252307j5fe05db1g8defc09e6eed988b@mail.gmail.com>
Subject: [PATCH V2 0/3] Make 64-bit PCI device tree scanning code common
To: benh@kernel.crashing.org, galak@kernel.crashing.org, sfr@canb.auug.org.au,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi guys

Here's v2 of the PCI device tree scanning code. =A0This is tested and
working on 32bit. =A0It needs to be tested on 64 bit, but there shouldn't
be any behavioural changes. =A0It's mostly just a code move with a little
bit of fixups to merge code. =A0I'd like to see this go into .32 when the
merge window opens.

Changes in v2:
- Move scanning code into its own file: pci_of_scan.c

On Thu, Aug 20, 2009 at 11:30 PM, Grant Likely<grant.likely@secretlab.ca> w=
rote:
> Ben and Kumar,
>
> Compile tested only. =A0I haven't even tried to boot this on real
> hardware, but I'm posting so that you guys can see what I'm up to.
> Basically, I want access to the device tree scanning in ppc32 land,
> and these patches start to get me there. =A0Please take a look and
> comment. =A0Tomorrow I'll actually try running this stuff and debugging
> the details.
>

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
