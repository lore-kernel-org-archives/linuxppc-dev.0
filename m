Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 95770DDF70
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 06:43:58 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2JJhtXS024014
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 15:43:55 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2JJhti1066782
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 13:43:55 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2JJhtfW007818
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 13:43:55 -0600
Date: Mon, 19 Mar 2007 14:43:49 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/11] ppc64: EEH: modifications, fixes
Message-ID: <20070319194349.GT5151@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Paul,

Please apply the following series of patches. The arrival of power6 has
required some cleanup and restructuring of code; this patch series fixes
several bugs, handles some unsual firmware versions, and in general
makes the EEH recovery process more compliant with the firmware spec.

Developed & tested on power4/5/6, on as many boxes as I could get my hands on.

--linas
