Return-Path: <jarno.manninen@tut.fi>
Received: from kivi.ton.tut.fi (kivi.ton.tut.fi [193.166.235.14])
	by ozlabs.org (Postfix) with ESMTP id 7C9FC679EF
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Jun 2005 05:52:56 +1000 (EST)
Received: from b34.paawola.ton.tut.fi ([195.148.75.85] helo=amd64)
	by kivi.ton.tut.fi with esmtp (Exim 3.35 #1 (Debian))
	id 1Df1Hh-0003lM-00
	for <linuxppc-embedded@ozlabs.org>; Sun, 05 Jun 2005 22:59:49 +0300
From: Jarno Manninen <jarno.manninen@tut.fi>
To: linuxppc-embedded@ozlabs.org
Date: Sun, 5 Jun 2005 22:29:44 +0300
References: <20050605141556.7B9CA679E6@ozlabs.org>
In-Reply-To: <20050605141556.7B9CA679E6@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="gb2312"
Message-Id: <200506052229.44170.jarno.manninen@tut.fi>
Subject: Re: Help on the data rate on MPC5200 ethernet
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sunday 05 June 2005 17:09, xuetao wrote:

> I am testing the tcp/ip data communication data rate on MPC5200. The UDP
> data rate is up to 80Mbps and TCP data rate is only 10Mbps? I test the TCP
> data rate with FTP file traslation. Any body know the problem on this?

The mass storage may be the limiting factor here, ofcourse depending on your 
configuration. Anyhow I've found NTTCP test utility usefull for simple 
testing purposes. There's propably some other test suites floating around 
too.

- Jarno
