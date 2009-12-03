Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 2495AB7BE6
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Dec 2009 08:28:24 +1100 (EST)
To: David Hawkins <dwh@ovro.caltech.edu>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: PCI interrupt question
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <4B1816F9.1020601@ovro.caltech.edu>
References: <1259821316.12651.26.camel@qu102.quarc.com>
	<4B17F14A.1060001@ovro.caltech.edu>
	<1259869140.18190.52.camel@qu102.quarc.com>
	<4B1816F9.1020601@ovro.caltech.edu>
Date: Thu, 03 Dec 2009 22:28:21 +0100
Message-Id: <20091203212821.463D5E6D391@gemini.denx.de>
Cc: Jeff Hane <jeff.hane@maxim-ic.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear David Hawkins,

In message <4B1816F9.1020601@ovro.caltech.edu> you wrote:
> 
> Yep. It might require enabling a PCI subsystem in U-Boot.
> I recall playing with a Yosemite board and a PCI card,
> but I forget whether I had to do anything to enable
> PCI configuration space setup. Post a question to the
> U-Boot list.

PCI is enabled by default on the Canyonlands board, both in U-Boot and
Linux.


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"In the long run, every program becomes rococo, and then rubble."
- Alan Perlis
