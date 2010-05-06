Return-Path: <jwboyer@gmail.com>
Received: from mail-iw0-f185.google.com (mail-iw0-f185.google.com
	[209.85.223.185]) by ozlabs.org (Postfix) with ESMTP id A031CB7D5E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 May 2010 21:38:28 +1000 (EST)
Received: by iwn15 with SMTP id 15so8015852iwn.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 06 May 2010 04:38:26 -0700 (PDT)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Thu, 6 May 2010 07:38:16 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: Disable CONFIG_SYSFS_DEPRECATED
Message-ID: <20100506113816.GP2671@hansolo.jdub.homelinux.org>
References: <20100506033041.GA12203@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100506033041.GA12203@kryten>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 06, 2010 at 01:30:41PM +1000, Anton Blanchard wrote:
>
>CONFIG_SYSFS_DEPRECATED can cause issues with newer distros and should not
>be required for any distro in the last 3 or 4 years, so disable it.

I'd like to run a few tests with this disabled on the 4xx boards first please.
I can't say that all the boards I have will have any sort of "distro" to begin
with, and if they did they might not be running something from the last 3 or
4 years.  I do run -git kernels on them frequently though.

josh
