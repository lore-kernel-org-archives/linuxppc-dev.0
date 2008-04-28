Return-Path: <rdreier@cisco.com>
Received: from sj-iport-2.cisco.com (sj-iport-2.cisco.com [171.71.176.71])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-2.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 9663FDDE9F
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 09:00:10 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
Subject: Re: IB/ehca: handle negative return value from ibmebus_request_irq()
	properly in ehca_create_eq()
References: <200804281847.44968.hnguyen@linux.vnet.ibm.com>
Date: Mon, 28 Apr 2008 16:00:04 -0700
In-Reply-To: <200804281847.44968.hnguyen@linux.vnet.ibm.com> (Hoang-Nam
	Nguyen's message of "Mon, 28 Apr 2008 18:47:44 +0200")
Message-ID: <ada4p9lzitn.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
	Roel Kluin <12o3l@tiscali.nl>, linux-kernel@vger.kernel.org,
	general@lists.openfabrics.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

thanks, applied
