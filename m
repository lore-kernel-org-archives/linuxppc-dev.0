Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B779B67D8E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Dec 2006 03:19:25 +1100 (EST)
In-Reply-To: <22A704B880BBD94A9E52BD6FA90C63D78A316D@BUDMLVEM08.e2k.ad.ge.com>
References: <22A704B880BBD94A9E52BD6FA90C63D78A316D@BUDMLVEM08.e2k.ad.ge.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B814573F-A75A-46E2-90E3-0E156946066D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Ltib on PowerQUICC 8349
Date: Mon, 18 Dec 2006 10:19:28 -0600
To: "Awad, Sinan ((GE Healthcare))" <sinan.awad@med.ge.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Dec 18, 2006, at 2:07 AM, Awad, Sinan ((GE Healthcare)) wrote:

> Hello all
>
> Downloaded LTIB tgz (I'm behind a heavy proxy in my organization).
> Configures .ltibrc to have a proxy as explained, I run ./ltib, it  
> takes
> a while but then fails on connectivity problems.
> When I try to do a wget from the same location (bitshrine/gpp/...) I
> succeed, so why ltib isn't ?

These questions are best posted to the ltib mailing list.

ltib@nongnu.org

- k

>
> Thanks in advance
>
> ---------------------------------------------------------------------- 
> --
> Processing platform: host support
> ===================================
> (see logfile: /xxxxx/sinan/dev/linux/ltib-6.2.2-sv/host_config.log)
> using
>
> Processing: rpm-fs
> ====================
> Can't get GPP index, proxy forced off
> Testing ppp_url connectivity: FAIL, disabling
> Testing gpp_url connectivity: FAIL, disabling
> No network download connection available
>
> Started: Mon Dec 18 08:45:51 2006
> Ended:   Mon Dec 18 08:49:14 2006
> Elapsed: 203 seconds
>
> Build Failed
> ---------------------------------------------------------------------
>
> -----Original Message-----
> From: linuxppc-embedded-bounces+sinan.awad=ge.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+sinan.awad=ge.com@ozlabs.org] On
> Behalf Of linuxppc-embedded-request@ozlabs.org
> Sent: Monday, December 18, 2006 3:00 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: Linuxppc-embedded Digest, Vol 28, Issue 31
>
> Send Linuxppc-embedded mailing list submissions to
> 	linuxppc-embedded@ozlabs.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
> 	https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> or, via email, send a message with subject or body 'help' to
> 	linuxppc-embedded-request@ozlabs.org
>
> You can reach the person managing the list at
> 	linuxppc-embedded-owner@ozlabs.org
>
> When replying, please edit your Subject line so it is more specific  
> than
> "Re: Contents of Linuxppc-embedded digest..."
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
