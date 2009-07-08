Return-Path: <rdreier@cisco.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 61897B707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Jul 2009 08:26:18 +1000 (EST)
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-6.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id CAA4EDDDE5
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Jul 2009 08:26:17 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Alexander Schmidt <alexs@linux.vnet.ibm.com>
Subject: Re: [PATCH] ehca: use port autodetect mode as default
References: <20090707160639.6b45bf4d@BL3D1974.boeblingen.de.ibm.com>
Date: Wed, 08 Jul 2009 15:26:13 -0700
In-Reply-To: <20090707160639.6b45bf4d@BL3D1974.boeblingen.de.ibm.com>
	(Alexander Schmidt's message of "Tue, 7 Jul 2009 16:06:39 +0200")
Message-ID: <adamy7e24my.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: of-ewg <ewg@lists.openfabrics.org>, lkml <linux-kernel@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	of-general <general@lists.openfabrics.org>,
	Hoang-Nam Nguyen <HNGUYEN@linux.vnet.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

looks good, applied
