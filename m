Return-Path: <ak@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A839067B68
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 04:15:05 +1000 (EST)
From: Andi Kleen <ak@suse.de>
To: "Tim Pepper" <tpepper@gmail.com>
Subject: Re: libnuma interleaving oddness
Date: Wed, 30 Aug 2006 20:12:57 +0200
References: <20060829231545.GY5195@us.ibm.com> <200608300932.23746.ak@suse.de>
	<eada2a070608301101j205b2711va5c287dbf8aab492@mail.gmail.com>
In-Reply-To: <eada2a070608301101j205b2711va5c287dbf8aab492@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608302012.57592.ak@suse.de>
Cc: linux-mm@kvack.org, Nishanth Aravamudan <nacc@us.ibm.com>,
	linuxppc-dev@ozlabs.org, Christoph Lameter <clameter@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> On my list of random things to do is trying to improve the test
> coverage in this area.  We keep running into bugs or possible bugs or
> confusion on expected behaviour.  I'm going through the code trying to
> understand it and writing little programs to confirm my understanding
> here and there anyway.

numactl has a little regression test suite in test/* that tests a lot of stuff,
but not all. Feel free to extend it.

-Andi
