Return-Path: <eberhard.stoll@berghof.com>
Received: from mail117.messagelabs.com (mail117.messagelabs.com
	[195.245.231.211]) by ozlabs.org (Postfix) with SMTP id 14785679E0
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Mar 2006 19:06:30 +1100 (EST)
Message-ID: <44152802.2050000@berghof.com>
Date: Mon, 13 Mar 2006 09:06:26 +0100
From: Eberhard Stoll <eberhard.stoll@berghof.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: pppd in eldk
References: <200603121913.56832.antonio.dibacco@aruba.it>
In-Reply-To: <200603121913.56832.antonio.dibacco@aruba.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Antonio,

>I didn't find the ppp package in denx eldk, I tried to cross compile the 
>sources (from sourceforge) but I received some errors (pcap_t undeclared). 
>Before I continue I would investigate if someone was already successful with 
>ppp on ppc.
>  
>
We compiled pppd v. 2.4.1 with eldk 3.0 on our ppc target with nfs
mount. It was no problem. But compiling this package on our x86 linux
machine (SuSe 9.0)  wasn't a problem either after setting the
environment vars CC, LD, AS to appropriate values (ppc_82xx-...).

Bye
Eberhard
