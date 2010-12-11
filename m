Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 825AAB7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 12 Dec 2010 06:18:51 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH -mm 0/4] RapidIO: Misc updates
Date: Sat, 11 Dec 2010 11:18:17 -0800
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E55201665506@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <20101210151924.333afed7.akpm@linux-foundation.org>
References: <1292013498-31406-1-git-send-email-alexandre.bounine@idt.com>
	<20101210151924.333afed7.akpm@linux-foundation.org>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Andrew Morton" <akpm@linux-foundation.org>
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

Andrew Morton <akpm@linux-foundation.org> wrote:
> I held
> rapidio-use-common-destid-storage-for-endpoints-and-switches.patch and
> rapidio-integrate-rio_switch-into-rio_dev.patch back from 2.6.37 due
to
> ongoing discussion.  What is the situation now?

Sorry, it took me too long to do this follow-up.
Patches in this set are direct product of that discussion and address
the issue of unified switch identification brought by Micha Nelissen.
The implementation is different from what he would like to see but I
prefer to have minimal changes to the code combined with enough
flexibility to enable proprietary implementations if such are required.
Besides that discussion, I did not receive any complaints about the
changes that you are referencing above.


 =20
