Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id A9E43DE597
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Oct 2008 07:01:52 +1100 (EST)
Received: from [192.168.1.37] (66-81-71-59.bayarea.dialup.o1.com [66.81.71.59])
	(authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id m98JpovC035381
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Oct 2008 12:52:02 -0700 (PDT)
Message-ID: <48ED0F30.7080103@hypersurf.com>
Date: Wed, 08 Oct 2008 12:51:12 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: 8600 serial support
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

	I thought I might take a whack at fixing the 2.6 serial driver
for my 8600. At the top of pmac_zilog.c (2.6.26) there is a todo for DMA.
A quick glance at macserial.c (2.4.31) suggests it has dbdma support for
receive. Anyone know of any pitfalls for adding dbdma support for
pmac_zilog.c?

kevin
