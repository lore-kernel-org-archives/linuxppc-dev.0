Return-Path: <wrobell@pld-linux.org>
Received: from mx.it-zone.org (a.mx.it-zone.org [81.0.225.183])
	by ozlabs.org (Postfix) with SMTP id BD08867A75
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2006 01:45:50 +1100 (EST)
Subject: Re: 2.6.16 does not boot on powerbook
From: wrobell <wrobell@pld-linux.org>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <442925A8.6030004@rsbac.org>
References: <442925A8.6030004@rsbac.org>
Content-Type: text/plain
Date: Tue, 28 Mar 2006 15:38:25 +0100
Message-Id: <1143556705.3562.104.camel@RECENT-CONVERT>
Mime-Version: 1.0
Reply-To: wrobell@pld-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-03-28 at 14:01 +0200, Michal Purzynski wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> hey,
> 
> i've just installed 2.6.16 vanilla kernel on powerbook G4 but it cannot
> boot.
[...]
> my kernel config (the same config works on 2.6.15)
[...]
> # CONFIG_PPC_PMAC is not set

you have to go through configuration options carefully.
some of them are disabled because of ppc32/64 arch merging changes
(please correct me if i am wrong).

[...]

  wrobell <wrobell@pld-linux.org>
