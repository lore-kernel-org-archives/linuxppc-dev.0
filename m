Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id 9AE82DE0C4
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 06:07:10 +1000 (EST)
Received: from [192.168.1.37] (node29.77.251.72.1dial.com [72.251.77.29])
	(authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id m53K6liL043754
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jun 2008 13:07:04 -0700 (PDT)
Message-ID: <4845A44D.20404@hypersurf.com>
Date: Tue, 03 Jun 2008 13:06:37 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: cntlzw
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

	x86 has bsf and bsr. PPC has cntlzw which I think is equivalent to bsr. 
Anyone know of a sneaky algorithm to do bsf?

kevin
