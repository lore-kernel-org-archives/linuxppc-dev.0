Return-Path: <jwboyer@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id 14864DDEDA
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 18 Feb 2008 07:56:41 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1442746anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 17 Feb 2008 12:56:40 -0800 (PST)
Date: Sun, 17 Feb 2008 14:56:06 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Steve Heflin <sheflin@newagemicro.com>
Subject: Re: Sequoia NAND - others missing?
Message-ID: <20080217145606.73279fe3@zod.rchland.ibm.com>
In-Reply-To: <47b8524c.1286460a.1307.7530SMTPIN_ADDED@mx.google.com>
References: <20080217113932.02EBDDE127@ozlabs.org>
	<20080217071851.0edbf07f@vader.jdub.homelinux.org>
	<47b8524c.1286460a.1307.7530SMTPIN_ADDED@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sun, 17 Feb 2008 10:27:22 -0500
Steve Heflin <sheflin@newagemicro.com> wrote:

> Are there other devices (beside the NAND Flash Controller) that exist 
> on the AMCC-440EPx chip and are not supported by the current 
> Linux-2.6.25 ARCH=powerpc?

i2c, GPIO, the security stuff (if your version has that), and GPT.
Thought GPT has never really been supported in any kernel that I
remember.

Patches for i2c and GPIO are floating around somewhere I think.  Just
need to get them polished up and device-tree compliant.

josh
