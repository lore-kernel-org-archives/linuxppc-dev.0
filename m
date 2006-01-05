Return-Path: <SRS0=94UdLY=3B=writeme.com=sinan@yourhostingaccount.com>
Received: from mailout03.yourhostingaccount.com
	(outmail.yourhostingaccount.com [65.254.254.78])
	by ozlabs.org (Postfix) with ESMTP id 0E835688EE
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jan 2006 17:00:48 +1100 (EST)
Received: from scan09.yourhostingaccount.com ([10.1.1.239]
	helo=scan09.yourhostingaccount.com)
	by mailout03.yourhostingaccount.com with esmtp (Exim)
	id 1EuNuu-0004bV-KT
	for linuxppc-embedded@ozlabs.org; Thu, 05 Jan 2006 00:44:04 -0500
Received: from authsmtp05.yourhostingaccount.com ([10.1.18.5] ident=exim)
	by scan09.yourhostingaccount.com with spamscanlookuphost (Exim)
	id 1EuNuu-00007U-Hq
	for linuxppc-embedded@ozlabs.org; Thu, 05 Jan 2006 00:44:04 -0500
Received: from authsmtp05.yourhostingaccount.com ([10.1.18.5]
	helo=authsmtp05.yourhostingaccount.com)
	by scan09.yourhostingaccount.com with esmtp (Exim)
	id 1EuNur-00007K-65
	for linuxppc-embedded@ozlabs.org; Thu, 05 Jan 2006 00:44:01 -0500
Message-ID: <43BCB2C8.2040208@writeme.com>
Date: Thu, 05 Jan 2006 00:46:48 -0500
From: Sinan Akman <sinan@writeme.com>
MIME-Version: 1.0
To: batsayan.das@tcs.com,  linuxppc-embedded@ozlabs.org
References: <OF297B9EF6.35EC8CDF-ON652570ED.001A9607-652570ED.001B4CAD@tcs.com>
In-Reply-To: <OF297B9EF6.35EC8CDF-ON652570ED.001A9607-652570ED.001B4CAD@tcs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: Sinan Akman <sinan@writeme.com>
Subject: Re: Porting of Linux on MPC8260 custom build board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

batsayan.das@tcs.com wrote:

>
> [...] We have mounted the root fs by NSF.

    Really ? The following boot command says you intended otherwise !

> Kernel command line: root=/dev/mtdblock2

    [...]

> Please append a correct "root=" boot option

    Indeed ! Provide the correct root option to mount over nfs.

    Denx FAQ covers all these.

    Regards

    Sinan Akman
