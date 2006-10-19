Return-Path: <linas@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6A5EE67BE2
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 02:19:09 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9JGIvM4028038
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2006 12:18:57 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9JGIvJQ316922
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2006 10:18:57 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9JGIupr030138
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2006 10:18:57 -0600
Date: Thu, 19 Oct 2006 11:18:55 -0500
To: Nicolas DET <nd@bplan-gmbh.de>
Subject: Re: [PATCH] General CHRP/MPC5K2 Platform and drivers support - to
	comment
Message-ID: <20061019161855.GI6537@austin.ibm.com>
References: <453771E5.4090808@bplan-gmbh.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <453771E5.4090808@bplan-gmbh.de>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, tnt@246tNt.com, sl@bplan-gmbh.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 19, 2006 at 02:39:01PM +0200, Nicolas DET wrote:
> This 'big' patch adds support for CHRP/MPC52xx based platform. Here, 
> this is the bPlan's Efika computer 
> (http://www.bplan-gmbh.de/efika_spec_en.html)
> 
> We know this patch is not totaly compliant with Documentation/CodingStyle/.
> 
> We would like people to comment and review it. 

Can you send the patch unzipped, and not as an attachement? 
This would make reviewing and commenting much easier.

--linas
