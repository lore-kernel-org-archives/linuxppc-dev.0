Return-Path: <jwboyer@gmail.com>
Received: from ro-out-1112.google.com (ro-out-1112.google.com [72.14.202.182])
	by ozlabs.org (Postfix) with ESMTP id 9D49BDDE25
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Dec 2007 05:45:33 +1100 (EST)
Received: by ro-out-1112.google.com with SMTP id p7so2316509roc.1
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Dec 2007 10:45:32 -0800 (PST)
Date: Sun, 16 Dec 2007 12:45:20 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 4xx: Add aliases node to 4xx dts files
Message-ID: <20071216124520.6130edd4@hansolo.jdub.homelinux.org>
In-Reply-To: <f3ddb435a7a71cea8362ed73eb154200@kernel.crashing.org>
References: <1197705316-17618-1-git-send-email-sr@denx.de>
	<20071216061959.GD21311@localhost.localdomain>
	<20071216085858.55ffddbe@vader.jdub.homelinux.org>
	<f3ddb435a7a71cea8362ed73eb154200@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>, paulus@samba.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 16 Dec 2007 19:10:02 +0100
Segher Boessenkool <segher@kernel.crashing.org> wrote:

> > Applied to my candidates tree.  Though I'd really like dtc to be merged
> > so that we can figure out what the in-kernel version will support.
> 
> Hopefully some version that stores path strings in the properties
> in /aliases, and not phandles.  Or does that current version of DTC
> do that correctly already, and just has an inconvenient source syntax?

I have no idea.  I can't even keep track of whether various DTC
features are dts-v1 only or not, and which "version" of DTC supports
which features.  That's why I'm sort of waiting for Paul to merge
whatever version of DTC he is going to merge.  *HINT*

We should also probably make a clear cut DTC release Real Soon Now.
*HINT*

josh
