Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4DCA6DDFF3
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 02:34:09 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9BGY500017981
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 12:34:05 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9BGY5XI463918
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 12:34:05 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9BGY5Qi011596
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 12:34:05 -0400
Date: Thu, 11 Oct 2007 11:33:58 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v4 or so] Use 1TB segments
Message-ID: <20071011163358.GA4258@austin.ibm.com>
References: <18189.64726.824152.697844@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18189.64726.824152.697844@cargo.ozlabs.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Jon Tollefson <kniht@linux.vnet.ibm.com>,
	Will Schmidt <will_schmidt@vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 11, 2007 at 08:37:10PM +1000, Paul Mackerras wrote:
> This makes the kernel use 1TB segments for all kernel mappings and for
> user addresses of 1TB and above, on machines which support them
> (currently POWER5+, POWER6 and PA6T).

Gack. A system dump might take a while on these machines ... 

--linas
