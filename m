Return-Path: <mcr@sandelman.ottawa.on.ca>
Received: from cod.sandelman.ca (newcod.sandelman.ca [192.139.46.42])
	by ozlabs.org (Postfix) with ESMTP id 8335067CA5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Aug 2006 11:52:18 +1000 (EST)
From: Michael Richardson <mcr@sandelman.ottawa.on.ca>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Deactivate serial console? 
In-Reply-To: Message from Lee Revell <rlrevell@joe-job.com> of "Tue,
	22 Aug 2006 13:55:00 EDT." <1156269300.10565.180.camel@mindpipe>
References: <91B22F93A880FA48879475E134D6F0BE02EEA435@CA1EXCLV02.adcorp.kla-tencor.com>
	<1156269300.10565.180.camel@mindpipe>
Date: Tue, 22 Aug 2006 21:26:02 -0400
Message-ID: <20634.1156296362@sandelman.ottawa.on.ca>
Sender: mcr@sandelman.ottawa.on.ca
Cc: "Howard, Marc" <Marc.Howard@KLA-Tencor.com>,
	ppc <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


>>>>> "Lee" == Lee Revell <rlrevell@joe-job.com> writes:
    Lee> On Tue, 2006-08-22 at 10:46 -0700, Howard, Marc wrote:
    >> stty -F /dev/console 0

    Lee> Thanks - so if I read the man page correctly the 0 is interpreted as 0
    Lee> baud, and I would re-enable it by "stty -F /dev/console 115200"?

  Yes, and historically baud 0 meant 'hang up modem'.
  It causes DTR to drop. 

- -- 
]       ON HUMILITY: to err is human. To moo, bovine.           |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [

    "The Microsoft _Get the Facts CD_ does not work on Linux." - orospakr

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Finger me for keys

iQEVAwUBROuuqYCLcPvd0N1lAQIN4Qf/TtpVAE3baaZJt7UYp6Pogi1lyAjDpWZt
cf2rteFYzRBDmhQli8BSwobrGphPRpiCahUc6G/P2+gs6LS9djjgJ4vwv0+m/eLP
FFSG+67rh3lkZKay5sjHX7M03UKhFOuNv7N+Iiu/cJtDyz6FgBJSRPdztY4xN4h1
rGXRMvGMqHQlNEBkdN0bKv9TmhEpHgYMJdGlIn+BNh54f5Uet6/As1vzHosQJFR5
54jLDVG5PMYHXtpfOWDTW07QMSnljfZPtWi7Ixo/r04omjScyQGCpcbs4WzTXzf5
Ndc00cxX2AAoBMe1xyNMcq8aTlovuoEm1Zs15WJR7H8IBCrYm43zWw==
=pTam
-----END PGP SIGNATURE-----
