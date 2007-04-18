Return-Path: <linas@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 03F7EDDDF5
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2007 05:22:07 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3IJM4Su001376
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 15:22:04 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3IJM4pp198726
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 13:22:04 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3IJM3Ik028917
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 13:22:03 -0600
Date: Wed, 18 Apr 2007 14:22:03 -0500
To: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: Re: [PATCH 1/2] hvc_console polling mode timer backoff
Message-ID: <20070418192203.GA8281@austin.ibm.com>
References: <1176821087.28514.145.camel@farscape.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1176821087.28514.145.camel@farscape.rchland.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 17, 2007 at 09:44:46AM -0500, Will Schmidt wrote:
> 
> Add a back-off mechanism to hvc_console's polling logic.   This change

Acked-by: Linas Vepstas <linas@austin.ibm.com>

--linas
