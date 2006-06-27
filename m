Return-Path: <rlrevell@joe-job.com>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by ozlabs.org (Postfix) with SMTP id 9054067B42
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Jun 2006 12:01:12 +1000 (EST)
Subject: Re: Need help on ftp and telnet in my Ramdisk
From: Lee Revell <rlrevell@joe-job.com>
To: Denny <jxnuxdy@163.com>
In-Reply-To: <44A08AEC.000113.30549@bj163app63.163.com>
References: <44A00EF4.6000109@gmail.com> <44A01925.9050100@ovro.caltech.edu>
	<44A08AEC.000113.30549@bj163app63.163.com>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 22:01:12 -0400
Message-Id: <1151373673.26257.194.camel@mindpipe>
Mime-Version: 1.0
Cc: de@denx.de, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2006-06-27 at 09:33 +0800, Denny wrote:
> bash-3.00# ftp 192.168.65.143
> ftp: ftp/tcp: unknown service
> bash-3.00# telnet 192.168.65.143
> telnet: telnet: bad port 

These sound like /etc/services is missing?

Consider adding strace to your build, it saves a LOT of guessing.

Lee
