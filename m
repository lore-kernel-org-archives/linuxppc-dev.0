Return-Path: <rmcguire@videopresence.com>
Received: from smtpauth02.prod.mesa1.secureserver.net
	(smtpauth02.prod.mesa1.secureserver.net [64.202.165.182])
	by ozlabs.org (Postfix) with SMTP id D3190DDE37
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Feb 2007 01:28:00 +1100 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: <linuxppc-embedded@ozlabs.org>
References: <mailman.1454.1170226011.9285.linuxppc-embedded@ozlabs.org>
	<000601c74531$62220820$6405a8c0@absolut>
	<0ACC0A3E-9DF3-4927-8F67-E525BA0E6C13@kernel.crashing.org>
	<000001c7454b$69a25ae0$6405a8c0@absolut>
	<0A655A39-4101-48B4-BE9C-50A30163679C@kernel.crashing.org>
	<000701c7457a$d180e300$6405a8c0@absolut>
	<183E66A5-E983-4D17-96E9-2EEAE6FDF7B6@kernel.crashing.org>
	<000f01c74587$10bc5cf0$6405a8c0@absolut>
	<1546691E-0CCF-41C9-8B8A-7C6326CEEF7E@kernel.crashing.org>
	<000301c7458b$b9eb1330$6405a8c0@absolut>
	<829261C6-F534-4B85-A04D-8D280E46B2CF@kernel.crashing.org>
	<000401c74591$8a3a4ec0$6405a8c0@absolut>
	<BC5846DA-A217-43B7-8060-6EA05CC62913@kernel.crashing.org>
Subject: 8360E - PCI / DTC Blob Setup
Date: Thu, 1 Feb 2007 06:27:40 -0800
Message-ID: <000801c7460d$211e46e0$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <BC5846DA-A217-43B7-8060-6EA05CC62913@kernel.crashing.org>
Reply-To: rmcguire@videopresence.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Since I am hip deep in debugging the PCI system.

In the .dts files there is the section for the PCI setup.

The interrupt-map = < > 

Does this need to include:
1) A mapping for every IDSEL line in the system?
2) Only those IDSELs that are used on the slots on the motherboard?
3) A custom entry for every card we want to support?
4) How does a bridge chip and slave busses affect the entries, if at all?

Looking at the mpc8360 / 8349 setups that are part of the latest kernel
trees, some are place many and some are placing just a single entry?

Which should be the preferred method?

-Russ
