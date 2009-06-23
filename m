Return-Path: <rdreier@cisco.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 437D4B70FB
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Jun 2009 15:19:28 +1000 (EST)
Received: from sj-iport-2.cisco.com (sj-iport-2.cisco.com [171.71.176.71])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-2.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7B587DDD1C
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2009 15:19:27 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Alexander Schmidt <alexs@linux.vnet.ibm.com>
Subject: Re: [ewg] Re: [PATCH 2.6.31 try 2] ehca: Tolerate dynamic memory
	operations and huge pages
References: <200906091559.24661.hannes.hering@linux.vnet.ibm.com>
	<20090616091021.2acf7302@BL3D1974.boeblingen.de.ibm.com>
Date: Mon, 22 Jun 2009 22:19:21 -0700
In-Reply-To: <20090616091021.2acf7302@BL3D1974.boeblingen.de.ibm.com>
	(Alexander Schmidt's message of "Tue, 16 Jun 2009 09:10:21 +0200")
Message-ID: <adabpofr0h2.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hannes Hering <hannes.hering@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org, ewg@lists.openfabrics.org,
	linuxppc-dev@ozlabs.org, raisch@de.ibm.com,
	Hoang-Nam Nguyen <HNGUYEN@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

thanks, applied.

 > -#define HCAD_VERSION "0026"
 > +#define HCAD_VERSION "0027"

the driver version was already 0027 (since bde2cfaf), so I dropped this chunk.
