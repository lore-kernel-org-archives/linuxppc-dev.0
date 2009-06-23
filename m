Return-Path: <rdreier@cisco.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 98D63B70E2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Jun 2009 03:30:48 +1000 (EST)
Received: from sj-iport-2.cisco.com (sj-iport-2.cisco.com [171.71.176.71])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-2.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id C1BACDDDF0
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2009 03:30:47 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Alexander Schmidt <alexs@linux.vnet.ibm.com>
Subject: Re: [ewg] Re: [PATCH 2.6.31 try 2] ehca: Tolerate dynamic memory
	operations and huge pages
References: <200906091559.24661.hannes.hering@linux.vnet.ibm.com>
	<20090616091021.2acf7302@BL3D1974.boeblingen.de.ibm.com>
	<adabpofr0h2.fsf@cisco.com>
	<20090623101123.72690731@BL3D1974.boeblingen.de.ibm.com>
Date: Tue, 23 Jun 2009 10:30:43 -0700
In-Reply-To: <20090623101123.72690731@BL3D1974.boeblingen.de.ibm.com>
	(Alexander Schmidt's message of "Tue, 23 Jun 2009 10:11:23 +0200")
Message-ID: <adaljniq2m4.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hannes Hering <hannes.hering@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org, ewg@lists.openfabrics.org,
	linuxppc-dev@ozlabs.org, raisch@de.ibm.com,
	Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

applied...
