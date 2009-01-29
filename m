Return-Path: <gerickson@nuovations.com>
Received: from relay00.pair.com (relay00.pair.com [209.68.5.9])
	by ozlabs.org (Postfix) with SMTP id 83E7EDE0D6
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 07:40:56 +1100 (EST)
Date: Thu, 29 Jan 2009 12:40:47 -0800
Subject: Re: toolchain for building linux-2.6.27.8 or 2.6.28.1  ...
From: Grant Erickson <gerickson@nuovations.com>
To: <mike_timmons@trimble.com>
Message-ID: <C5A7544F.14345%gerickson@nuovations.com>
In-Reply-To: <498208E0.7000707@trimble.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/29/09 11:52 AM, Mike Timmons wrote:
> Questions:
> 1) if I want to cross-compile a kernel later than 2.6.24 to hopefully
> get better WAN device support (and clearer options for fw loading),
> which kernel should I try, and which toolchain?
> 
> the ltib repository does not appear to have a toolchain newer than
> gcc-3.4.3-glibc-2.3.6 (for 603e)
> 
> Admissions, disclaimers, etc
> 1) I'm using the same ltib script I have used for the 2.6.24 build with
> toolchain gcc-3.4.3-glibc-2.3.6 (for 603e).
> I'm simply modifying the kernel spec file to use 2.6.28.1 (and specifyin
> a custom toolchain).
> I've also tried to compile 2.6.27.8. I get the same error.

Mike:

Denx's ELDK 4.1 or 4.2 make a great "It Just Works" solution. I've used 4.1
running from 2.6.23 up to 2.6.27.11 and 4.2 from 2.6.26 to 2.6.27.11 with
zero problems or issues.

Regards,

Grant Erickson
