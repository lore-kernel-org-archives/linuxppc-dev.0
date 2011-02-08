Return-Path: <davej@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 72000B7129
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Feb 2011 04:29:17 +1100 (EST)
Date: Tue, 8 Feb 2011 12:29:11 -0500
From: Dave Jones <davej@redhat.com>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: [PATCH 1/2] misc: add CARMA DATA-FPGA Access Driver
Message-ID: <20110208172910.GA32742@redhat.com>
References: <1297121021-3522-1-git-send-email-iws@ovro.caltech.edu>
	<1297121021-3522-2-git-send-email-iws@ovro.caltech.edu>
	<20110208073309.GB906@core.coreip.homeip.net>
	<20110208172046.GB10125@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110208172046.GB10125@ovro.caltech.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 08, 2011 at 09:20:46AM -0800, Ira W. Snyder wrote:

 > > > +static DEVICE_ATTR(enable, S_IWUGO | S_IRUGO, data_en_show, data_en_set);
 > > 
 > > Are all of these really needed or most of them are for debug?
 > > 
 > 
 > Most are for debugging. They have proved useful a few times in
 > production to track down bugs.
 
File mode should probably not be world writable.
(checkpatch.pl should warn you about this now btw)

	Dave
