Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D632FB70A5
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 11 Dec 2010 10:22:48 +1100 (EST)
Date: Fri, 10 Dec 2010 15:22:33 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexandre Bounine <alexandre.bounine@idt.com>
Subject: Re: [PATCH -mm 4/4] RapidIO: Add new sysfs attributes
Message-Id: <20101210152233.3786b432.akpm@linux-foundation.org>
In-Reply-To: <1292013498-31406-5-git-send-email-alexandre.bounine@idt.com>
References: <1292013498-31406-1-git-send-email-alexandre.bounine@idt.com>
	<1292013498-31406-5-git-send-email-alexandre.bounine@idt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, Thomas Moll <thomas.moll@sysgo.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 10 Dec 2010 15:38:18 -0500
Alexandre Bounine <alexandre.bounine@idt.com> wrote:

> Add new sysfs attributes.

One would like to see documentation updates along with sysfs API
updates.  But one fears that this entire interface wasn't documented
anyway :(

Please at least fully describe the proposed interface in the changelog
so others can review the proposal.

The proposed new sysfs files appear to break the
one-value-per-sysfs-file rule.
