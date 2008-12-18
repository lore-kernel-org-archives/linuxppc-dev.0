Return-Path: <jwboyer@gmail.com>
Received: from mail-qy0-f21.google.com (mail-qy0-f21.google.com
	[209.85.221.21]) by ozlabs.org (Postfix) with ESMTP id CEEA4DDF96
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 06:02:34 +1100 (EST)
Received: by qyk14 with SMTP id 14so941705qyk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 11:02:32 -0800 (PST)
Date: Thu, 18 Dec 2008 14:02:08 -0500
From: Josh Boyer <jwboyer@gmail.com>
To: Felix Radensky <felix@embedded-sol.com>
Subject: Re: Long boot delay on 460EX with 2.6.28-rc8
Message-ID: <20081218190208.GC18201@yoda.jdub.homelinux.org>
References: <21070179.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <21070179.post@talk.nabble.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 18, 2008 at 02:29:52AM -0800, Felix Radensky wrote:
>
>Hi,
>
>I'm experiencing a long (around 20 sec) delay from the moment
>u-boot-1.3.4 passes control to linux and until the first kernel message
>appears on console. This happens on custom board, I don't have access
>to Canyonlands to test how it behaves. I did not modify anything in kernel 
>code to make it boot on custom board, just removed PCIX and PCIE0 nodes
>from DTS.
>
>Has anyone experienced similar behavior with 460EX ? Any hints what can
>cause this ?

I booted on a canyonlands this morning (after having removed the brown
paper bag that preventing me from booting it yesterday).  I saw no
delay.

josh
