Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-pb-sasl-sd.pobox.com [64.74.157.62])
	by ozlabs.org (Postfix) with ESMTP id 62DEFB6F88
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Mar 2011 00:52:39 +1100 (EST)
Subject: Re: High load average (~2.0) on an idle PowerPC 64 machine
From: Nathan Lynch <ntl@pobox.com>
To: David Laight <David.Laight@ACULAB.COM>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8ACA1@saturn3.aculab.com>
References: <AE90C24D6B3A694183C094C60CF0A2F6D8ACA1@saturn3.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 25 Mar 2011 08:46:57 -0500
Message-ID: <1301060817.5967.2.camel@tp-t61>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-03-25 at 09:23 +0000, David Laight wrote:
> We also have the related fubar (on x64/amd64) of the
> kernel generating stack traces for processes that are
> sleeping uninterruptibly for long periods.

Turn off CONFIG_DETECT_HUNG_TASK?
