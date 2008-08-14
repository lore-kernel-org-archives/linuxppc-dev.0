Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id 338C7DE0DF
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 06:37:25 +1000 (EST)
Received: from [192.168.1.37] (node150.74.251.72.1dial.com [72.251.74.150])
	(authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id m7EKb23H003973
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Aug 2008 13:37:18 -0700 (PDT)
Message-ID: <48A49693.6030108@hypersurf.com>
Date: Thu, 14 Aug 2008 13:33:23 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: __attribute_used__ in 2.6.24
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

	Something in a function signature called "__attribute_used__" would 
compile in 2.6.24. This does not compile in 2.6.26. Using the 
"store_##NAME" template from arch/powerpc/kernel/sysfs.c as a guide, 
this appears to have changed to "__used". Anything work in both? 
"__used" seems to have compiled in 2.6.24?

kevin
